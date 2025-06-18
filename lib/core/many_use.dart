import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

AutoSizeText autoSizeText(String text, {double? fontSize, FontWeight? fontWeight, TextOverflow? overflow, double? minFontSize, TextAlign? textAlign,
  Color? color, AutoSizeGroup? group, int? maxLines, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle}){
  return AutoSizeText(text, minFontSize: minFontSize ?? 1, maxLines: maxLines ?? 1, group: group, textAlign: textAlign,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color, overflow: overflow,
        decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle),);
} 