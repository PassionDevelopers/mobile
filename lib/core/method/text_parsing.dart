import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

Text parseAiTextSummary(String text, double fontSize, Color boldColor) {
  final List<String> paras = text.split('(sep)');
  List<TextSpan> spans = [];
  for (int p = 0; p < paras.length; p++) {

    List<String> boldParts = paras[p].split('**');
    for(int i = 0; i < boldParts.length; i++) {
      spans.add(TextSpan(
        text: boldParts[i],
        style: TextStyle(
            fontSize: fontSize,
            // fontFamily: i % 2 == 1 ? 'esamanru' : null,
            letterSpacing: 0.8,
            height: 1.5,
            fontWeight: i % 2 == 1 ? FontWeight.w800 : FontWeight.normal,
            // color: i % 2 == 1 ? boldColor : AppColors.textPrimary,
            color: AppColors.gray5,
            // fontStyle: FontStyle.italic
            // decoration: i % 2 == 1 ? TextDecoration.lineThrough : null,
            // decorationThickness: 8,
            // decorationColor: Colors.amberAccent.withOpacity(0.3)
        ),
      ));
    }
  }
  return Text.rich(
    maxLines: 2,
    TextSpan(
      children: spans,
    ),
    textAlign: TextAlign.start,
  );
}

Text parseAiText(String text, double fontSize, Color boldColor, Color highlightColor) {
  final List<String> paras = text.split('(sep)');
  List<TextSpan> spans = [];
  for (int p = 0; p < paras.length; p++) {

    List<String> boldParts = paras[p].split('**');
    for(int i = 0; i < boldParts.length; i++) {
      spans.add(TextSpan(
        text: '${p != 0 && i==0? '\n\n' : '' }${i == 0 && paras.length > 1? '• ' :  i == 0? ' ' : '' }${boldParts[i]}',
        style: TextStyle(
          fontSize: fontSize,
          // fontSize: i % 2 == 1 ? fontSize *0.95 : fontSize,
          // fontFamily: i % 2 == 1 ? 'HakgyoansimTuhoR' : null,
          // fontFamily: i % 2 == 1 ? 'esamanru' : null,
          letterSpacing: 0.8,
          height: 1.5,

          fontWeight: i % 2 == 1 ? FontWeight.w800 : FontWeight.normal,
          color: i % 2 == 1 ? boldColor : AppColors.gray1,
          decoration: i % 2 == 1 ? TextDecoration.lineThrough : null,
          decorationThickness: fontSize,
          decorationColor: highlightColor.withOpacity(0.2)
        ),
      ));
    }
  }
  return Text.rich(
    TextSpan(
      children: spans,
    ),
    textAlign: TextAlign.start,
  );
}