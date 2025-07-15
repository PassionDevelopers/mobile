import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';



Text parseAiText(String text, double fontSize, Color boldColor) {
  final List<String> paras = text.split('(sep)');
  List<TextSpan> spans = [];
  for (int p = 0; p < paras.length; p++) {

    List<String> boldParts = paras[p].split('**');
    for(int i = 0; i < boldParts.length; i++) {
      spans.add(TextSpan(
        text: '${p != 0 && i==0? '\n\n' : '' }${i == 0? '• ' : '' }${boldParts[i]}',
        style: TextStyle(
          fontSize: fontSize,
          letterSpacing: 0.8,
          height: 1.5,
          fontWeight: i % 2 == 1 ? FontWeight.bold : FontWeight.normal,
          color: i % 2 == 1 ? boldColor : AppColors.gray1,
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