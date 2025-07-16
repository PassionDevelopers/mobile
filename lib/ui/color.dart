import 'dart:ui';

import 'package:flutter/material.dart';

List<BoxShadow> myShadow = [BoxShadow(
  color: AppColors.gray4,
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(0, 1), // changes position of shadow
)];

abstract class AppColors {

  static Color right = Color.fromRGBO(226, 93, 114, 1);
  // E25D72

  // static Color center = Color(0xffE5D9F2);
  static Color center = Color(0xffA294F9);
  static Color left = Color.fromRGBO(53, 195, 243, 1);
  // 35C3F3
  static Color background = Colors.grey.shade100;
  static Color primary = Color(0xff0A0A0B);

  static Color kakao = Color(0xffFEE500); // 카카오 색상
  static Color kakaoText = Color.fromRGBO(0, 0, 0, 0.85); // 카카오 텍스트 색상

  /////////////////////////////////////////////
  static Color primaryLight = Colors.white; // 라이트 모드에서의 기본 색상
  static Color secondary = Colors.grey.shade600;
  static Color tertiary = Color(0xff2D2D30);// 라이

  static const Color black = Color(0xFF000000);
  static const Color gray1 = Color(0xFF484848);
  static const Color gray2 = Color(0xFF797979);
  static const Color gray3 = Color(0xFFA9A9A9);
  static const Color gray4 = Color(0xFFD9D9D9);
  static const Color gray5 = Color(0xFFF2F2F2);
  static const Color white = Color(0xFFFFFFFF);

  static Color surface = Color(0xffFAFAFA);// 오프 화이트

  // static Color card = Color(0xffF8F9FA); // 라이트 그레이

  static Color leftCenter = Colors.blue.shade100;

   // 연한 보라
  // static Color centerLight = Color(0xffCDC1FF);
  static Color rightCenter = Colors.red.shade100;

  static const Color check = Color.fromRGBO(66, 196, 154, 1);

  // 텍스트 컬러
  static Color textPrimary = Colors.black87;
  static Color textPrimaryLight = Color(0xffFAFAFA); // 라이트 모드에서의 기본 텍스트 색상
  static Color textSecondary = Colors.grey.shade600; // 서브 텍스트
  static Color textTertiary = Color(0xff8E8E93); // 라이트 텍스트
  static Color textDate = Colors.grey.shade500;

  // 기능 컬러
  static Color border = Color(0xffE5E7EB); // 보더
  static Color hover = Color(0xffF3F4F6); // 호버 상태
  static Color active = Color(0xffE5E7EB); // 액티브 상태
  static Color unselected = Color(0xffE5E7EB); // 비활성화된 탭

  // 액센트 컬러 (CTA, 강조용)
  static Color success = Color(0xff00b894); // 성공 색상
  static Color warning = Color(0xffe17055); // 경고 색상
}

