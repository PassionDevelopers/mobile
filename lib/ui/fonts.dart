import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import 'color.dart';

class MyFontSizes {
  MyFontSizes._();
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double extraLarge = 18.0;
  static const double accent = 32.0;
}

class MyFontStyle{
  MyFontStyle._();
  static TextStyle reg = TextStyle(
    fontSize: MyFontSizes.small,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary
  );

  static var h1 = TextStyle(
    fontSize: MyFontSizes.extraLarge,
    fontWeight: FontWeight.w700,
      color: AppColors.textPrimary
  );

  static TextStyle? h2 = TextStyle(
    fontSize: MyFontSizes.large,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary
  );

  static TextStyle? h2w = TextStyle(
    fontSize: MyFontSizes.large,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryLight
  );

  static TextStyle? h3 = TextStyle(
    fontSize: MyFontSizes.medium,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary
  );

  static TextStyle? accent = TextStyle(
    fontSize: MyFontSizes.accent,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary
  );
}

class MyText {
  MyText._();

  static AutoSizeText h1(String text,){
    return AutoSizeText(text, style: MyFontStyle.h1,);
  }

  static AutoSizeText h2(String text, {Color? color}){
    return AutoSizeText(text, style: MyFontStyle.h2!.copyWith(color: color),);
  }
  static AutoSizeText h2w(String text, {Color? color}){
    return AutoSizeText(text, style: MyFontStyle.h2w!.copyWith(color: color),);
  }
  static AutoSizeText h3(String text, {Color? color}){
    return AutoSizeText(text, style: MyFontStyle.h3!.copyWith(color: color), maxLines: 1,);
  }

  static AutoSizeText reg(String text, {Color? color, AutoSizeGroup? group}){
    return AutoSizeText(text, style: MyFontStyle.reg.copyWith(color: color, ), group: group, maxLines: 1, minFontSize: 1,);
  }
  static AutoSizeText accent(String text, {Color? color}){
    return AutoSizeText(text, style: MyFontStyle.accent!.copyWith(color: color),);
  }
}