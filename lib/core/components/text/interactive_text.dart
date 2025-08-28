import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../data/terminology_dictionary.dart';
import '../tooltip/rich_tooltip.dart';
import '../../../ui/color.dart';

class InteractiveText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color highlightColor;

  const InteractiveText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.highlightColor,
  });

  @override
  State<InteractiveText> createState() => _InteractiveTextState();
}

class _InteractiveTextState extends State<InteractiveText> {
  OverlayEntry? _overlayEntry;
  
  void _showTooltip(BuildContext context, TermDefinition termDef, Offset tapPosition) {
    _removeTooltip();

    _overlayEntry = OverlayEntry(
      builder: (context) => _TooltipOverlay(
        termDefinition: termDef,
        position: tapPosition,
        onClose: _removeTooltip,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  List<TextSpan> _buildInteractiveSpans() {
    log('Building interactive spans for text: ${widget.text}');
    
    final List<String> paras = widget.text.split('(sep)');
    List<TextSpan> spans = [];
    
    for (int p = 0; p < paras.length; p++) {
      List<String> boldParts = paras[p].split('**');
      
      for (int i = 0; i < boldParts.length; i++) {
        String currentText = '${p != 0 && i == 0 ? '\n\n' : ''}${i == 0 && paras.length > 1 ? '• ' : i == 0 ? '' : ''}${boldParts[i]}';
        
        // 용어 찾기 및 분할
        List<TextSpan> termSpans = _buildTermSpans(
          currentText,
          i % 2 == 1, // isBold
        );
        
        spans.addAll(termSpans);
      }
    }
    
    return spans;
  }

  List<TextSpan> _buildTermSpans(String text, bool isBold) {
    List<TextSpan> spans = [];
    String remainingText = text;
    int currentIndex = 0;

    // 모든 용어에 대해 검색
    Map<int, TermDefinition> foundTerms = {

    };
    
    for (String term in TerminologyDictionary.getAllTerms()) {
      int index = remainingText.indexOf(term);
      while (index != -1) {
        // 중복되지 않는 위치에만 추가
        bool hasOverlap = false;
        for (MapEntry<int, TermDefinition> existing in foundTerms.entries) {
          if ((index < existing.key + existing.value.term.length) &&
              (index + term.length > existing.key)) {
            hasOverlap = true;
            break;
          }
        }
        
        if (!hasOverlap) {
          TermDefinition? termDef = TerminologyDictionary.findTerm(term);
          if (termDef != null) {
            foundTerms[index] = termDef;
          }
        }
        
        // 다음 occurrence 찾기
        index = remainingText.indexOf(term, index + 1);
      }
    }

    // 위치별로 정렬
    var sortedTerms = foundTerms.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    int lastEnd = 0;
    
    for (var entry in sortedTerms) {
      int start = entry.key;
      TermDefinition termDef = entry.value;
      int end = start + termDef.term.length;
      
      // 이전 텍스트 추가
      if (start > lastEnd) {
        spans.add(TextSpan(
          text: remainingText.substring(lastEnd, start),
          style: _getTextStyle(isBold, false),
        ));
      }
      
      // 용어 텍스트 추가 (터치 가능)
      spans.add(TextSpan(
        text: termDef.term,
        style: _getTextStyle(isBold, true),
        recognizer: _createTapRecognizer(termDef),
      ));
      
      lastEnd = end;
    }
    
    // 남은 텍스트 추가
    if (lastEnd < remainingText.length) {
      spans.add(TextSpan(
        text: remainingText.substring(lastEnd),
        style: _getTextStyle(isBold, false),
      ));
    }
    
    // 용어가 없으면 전체 텍스트 반환
    if (spans.isEmpty) {
      spans.add(TextSpan(
        text: remainingText,
        style: _getTextStyle(isBold, false),
      ));
    }
    
    return spans;
  }

  TextStyle _getTextStyle(bool isBold, bool isTerm) {
    return TextStyle(
      fontSize: widget.fontSize,
      letterSpacing: 0.8,
      height: 1.5,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.normal,
      color:
      // isTerm? widget.highlightColor.withOpacity(0.8) :
      (isBold ? widget.textColor : AppColors.gray1),
      decoration: isBold ? TextDecoration.lineThrough :

                  (isTerm ? TextDecoration.underline : null),
      decorationThickness: isBold ? widget.fontSize : 1,
      decorationColor: isBold ? widget.highlightColor.withOpacity(0.2) : widget.highlightColor,
    );
  }

  TapGestureRecognizer _createTapRecognizer(TermDefinition termDef) {
    return TapGestureRecognizer()
      ..onTapDown = (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        final Offset globalPosition = renderBox.localToGlobal(localPosition);
        
        _showTooltip(context, termDef, globalPosition);
      };
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: _buildInteractiveSpans()),
      textAlign: TextAlign.start,
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  final TermDefinition termDefinition;
  final Offset position;
  final VoidCallback onClose;

  const _TooltipOverlay({
    required this.termDefinition,
    required this.position,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const tooltipWidth = 300.0;
    const tooltipHeight = 400.0;

    // 툴팁 위치 계산 (스마트 포지셔닝)
    double left = position.dx - tooltipWidth / 2;
    double top = position.dy - tooltipHeight - 20;

    // 화면 경계 조정
    if (left < 20) left = 20;
    if (left + tooltipWidth > screenSize.width - 20) {
      left = screenSize.width - tooltipWidth - 20;
    }
    if (top < MediaQuery.of(context).padding.top + 20) {
      top = position.dy + 20;
    }

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {}, // 툴팁 내부 터치는 무시
        child: Material(
          color: Colors.transparent,
          child: RichTooltip(
            termDefinition: termDefinition,
            onClose: onClose,
          ),
        ),
      ),
    );
  }
}

