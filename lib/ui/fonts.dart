import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

abstract class MyFontSizes {
  static const double smaller = 10.0;
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double article = 17.0;
  static const double extraLarge = 18.0;
  static const double accent = 32.0;
}

abstract class MyFontStyle{

  static TextStyle small = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.smaller,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  ));

  static TextStyle reg = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.small,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  ));

  static TextStyle article = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.article,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  ));

  static var h1 = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.extraLarge,
    fontWeight: FontWeight.w700,
      color: AppColors.textPrimary
  ));

  static TextStyle h2 = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.large,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary
  ));

  static TextStyle h2w = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.large,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryLight
  ));

  static TextStyle h3 = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.medium,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary
  ));

  static TextStyle accent = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.accent,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary
  ));
}

abstract class MyText {

  static AutoSizeText h1(String text,){
    return AutoSizeText(text, style: MyFontStyle.h1,);
  }

  static AutoSizeText h2(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.h2.copyWith(color: color), group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }
  static AutoSizeText h2w(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.h2w.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }
  static AutoSizeText h3(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.h3.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static Text article(String text, {Color? color}){
    return Text(text, style: MyFontStyle.article.copyWith(color: color));
  }

  static AutoSizeText reg(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.reg.copyWith(color: color, ), group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText small(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.small.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText accent(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.accent.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }
}