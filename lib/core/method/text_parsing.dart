import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

Text parseAiText(String text, double fontSize) {
  final List<String> paras = text.split('(sep)');
  String result = '';
  for (final para in paras) {
    if (para.isNotEmpty) {
      result += '• $para\n\n';
    }
  }
  return Text(
    result,
    style: TextStyle(
      letterSpacing: 0.8,
      fontSize: fontSize,
      height: 1.5,
      color: AppColors.gray1,
    ),
    textAlign: TextAlign.justify,
  );
}