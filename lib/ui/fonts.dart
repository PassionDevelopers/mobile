import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';
import '../core/responsive/responsive_utils.dart';

abstract class MyFontSizes {
  static const double smaller = 10.0;
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double article = 17.0;
  static const double extraLarge = 20.0;
  static const double h0 = 22.0;
  static const double accent = 32.0;
}

abstract class ResponsiveFontSizes {
  // 모바일 폰트 사이즈
  static const double mobileSmaller = 10.0;
  static const double mobileSmall = 12.0;
  static const double mobileMedium = 14.0;
  static const double mobileLarge = 16.0;
  static const double mobileExtraLarge = 20.0;
  static const double mobileH0 = 22.0;
  static const double mobileAccent = 32.0;
  
  // 태블릿 폰트 사이즈
  static const double tabletSmaller = 11.0;
  static const double tabletSmall = 13.0;
  static const double tabletMedium = 15.0;
  static const double tabletLarge = 17.0;
  static const double tabletExtraLarge = 22.0;
  static const double tabletH0 = 24.0;
  static const double tabletAccent = 36.0;
  
  // 데스크탑 폰트 사이즈
  static const double desktopSmaller = 12.0;
  static const double desktopSmall = 14.0;
  static const double desktopMedium = 16.0;
  static const double desktopLarge = 18.0;
  static const double desktopExtraLarge = 24.0;
  static const double desktopH0 = 28.0;
  static const double desktopAccent = 40.0;
}

class ResponsiveFontSize {
  static double getSmaller(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return ResponsiveFontSizes.mobileSmaller;
    } else if (ResponsiveUtils.isTablet(context)) {
      return ResponsiveFontSizes.tabletSmaller;
    } else {
      return ResponsiveFontSizes.desktopSmaller;
    }
  }
  
  static double getSmall(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return ResponsiveFontSizes.mobileSmall;
    } else if (ResponsiveUtils.isTablet(context)) {
      return ResponsiveFontSizes.tabletSmall;
    } else {
      return ResponsiveFontSizes.desktopSmall;
    }
  }
  
  static double getMedium(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return ResponsiveFontSizes.mobileMedium;
    } else if (ResponsiveUtils.isTablet(context)) {
      return ResponsiveFontSizes.tabletMedium;
    } else {
      return ResponsiveFontSizes.desktopMedium;
    }
  }
  
  static double getLarge(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return ResponsiveFontSizes.mobileLarge;
    } else if (ResponsiveUtils.isTablet(context)) {
      return ResponsiveFontSizes.tabletLarge;
    } else {
      return ResponsiveFontSizes.desktopLarge;
    }
  }
  
  static double getExtraLarge(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return ResponsiveFontSizes.mobileExtraLarge;
    } else if (ResponsiveUtils.isTablet(context)) {
      return ResponsiveFontSizes.tabletExtraLarge;
    } else {
      return ResponsiveFontSizes.desktopExtraLarge;
    }
  }
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

  static TextStyle articleSmall = GoogleFonts.notoSansKr(textStyle: TextStyle(
    fontSize: MyFontSizes.medium,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  ));

  static TextStyle h0 = GoogleFonts.notoSansKr(textStyle: TextStyle(
      fontSize: MyFontSizes.h0,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary
  ));

  static TextStyle h1 = GoogleFonts.notoSansKr(textStyle: TextStyle(
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

  static AutoSizeText h0(String text,{Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.h0, group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText h1(String text,{Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.h1.copyWith(color: color), group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText h2(String text, {Color? color, AutoSizeGroup? group, int? maxLines, double? fontSize}){
    return AutoSizeText(text, style: MyFontStyle.h2.copyWith(color: color, fontSize: fontSize), group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
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

  static Text articleSmall(String text, {Color? color}){
    return Text(text, style: MyFontStyle.articleSmall.copyWith(color: color));
  }

  static AutoSizeText reg(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.reg.copyWith(color: color, ), group: group, maxLines: maxLines ?? 1, minFontSize: 1,
        overflow: TextOverflow.ellipsis);
  }

  static Text regSummary(String text, {Color? color, int? maxLines}){
    return Text(text, style: MyFontStyle.reg.copyWith(color: color, ), maxLines: maxLines ?? 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText small(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.small.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }

  static AutoSizeText accent(String text, {Color? color, AutoSizeGroup? group, int? maxLines}){
    return AutoSizeText(text, style: MyFontStyle.accent.copyWith(color: color),group: group, maxLines: maxLines ?? 1, minFontSize: 1, overflow: TextOverflow.ellipsis);
  }
}