import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color primary = Color(0xff0A0A0B);
  static Color primaryLight = Colors.white; // 라이트 모드에서의 기본 색상
  static Color secondary = Colors.grey.shade600;
  static Color tertiary = Color(0xff2D2D30);// 라이트 차콜

  // static Color background = Color(0xffffffff);
  static Color background = Colors.grey.shade100;
  static Color surface = Color(0xffFAFAFA);// 오프 화이트

  // static Color card = Color(0xffF8F9FA); // 라이트 그레이
  static Color card = Color(0xffffffff); // 글래스모피즘 효과를 위한 반투명 흰색

  static Color left = Color.fromRGBO(53, 175, 223, 1);
  // static Color left = Color.fromRGBO(220, 38, 38, 1); // 따뜻한 빨강
  static Color leftCenter = Colors.blue.shade100;
  // static Color center = Colors.grey.shade700;
  static Color center = Color(0xff9B7EBD);

  static Color right = Color.fromRGBO(226, 93, 114, 1);
  // static Color right = Color.fromRGBO(37, 99, 235, 1); // 클래식 블루
  static Color rightCenter = Colors.red.shade100;

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

}


class NoteColor{
  static const Color
  black = Colors.black,
      red = Colors.red,
      focused = Color(0xff21bf9b)
  ;
}

class GenreColor{
  static const Color
  top20 = AbpColor.r19,
      myMusic = AbpColor.c6,
      purchased = AbpColor.c5,
      jazz = Color(0xff27548A),
      classic = Color(0xffA86523),
      pop = Color(0xffFF8882),
      ost = Color(0xffA4B465),
      rnb = Color(0xffAA60C8),
      rock = Color(0xffBF3131),
  // hip = Color(0xff16C47F),
      hip = Colors.green,
      dance = Colors.orange,
      indie = Colors.black,
      religious = Color(0xff6FE6FC),
      tradition = Color(0xffDDA853),
      etc = Color(0xff735557)
  ;
}

class AbpColor{
  static const Color
  grey1 = Color.fromRGBO(219, 219, 219, 1), //not selected tabSelector indicator

      mint1 = Color.fromRGBO(30, 183, 189, 1),

      like = Colors.blue,
      unlike = Colors.red
  ;

  //////////////////////////////////////////////////////

  static const melody = Color(0xFF4ADE80),
      chord =  Color(0xFF60A5FA),
      bass = Color(0xFFC084FC);

  static const itemColor = Colors.white;

  static const cr1 = AbpColor.c3;
  static const wr1 = AbpColor.c7;

  static const c1 = Color(0xff21bf9b);
  static const c0 = Color.fromRGBO(50, 152, 141, 1);
  static const c1Origin = Color(0xff46ACA1);
  static const c11 = Color.fromRGBO(070, 172, 161,1); // 46ACA1
  static const c52 = Color(0xff82DBd8);
  static const c35 = Color.fromRGBO(100, 202, 191, 1);
  static const c2 = Colors.grey; // 현재 회색
  static const c22 = Color(0xffDFDFDE);
  static const c222 = Color(0xffE1E8EB);

  static const m1 = Color(0xffFF8882);
  static const m2 = Color.fromRGBO(255, 136, 130, 0.5);

  static const g1 = Color(0xffFFd124);
  static const g2 = Color(0xffFFE652);
  static const g3 = Color(0xffd4Ac2B);

  static const r19 = Color.fromRGBO(255, 165, 0, 1);
  static const r29 = Color.fromRGBO(255, 165, 0, 0.5),
      r39 = Color.fromRGBO(215, 125, 0, 0.5);

  static const t1 = Color.fromRGBO(0, 0, 0, 0.3);

  static const t2 = Color.fromRGBO(150, 150, 150, 0.3);

  static const c4 = Color(0xffF7F5F2);
  static const starC = Color(0xffFFD32D);
  static const gemC = Color(0xff40DFEF); //diamond
  static const c5 = Color(0xfffecb00);
  static const c5_1 = Color.fromRGBO(244,195,0,1);
// const AbpColor.c5 = Color(0xffFFCE45); // 골드
  static const c6 = Color(0xffff7474); // 하트 색, 핑크 노트 색
//const AbpColor.c7 = Color(0xffDAbpColor.d4A48); // 빨강
  static const c7 = Color.fromRGBO(241, 94, 92, 1);
  static const c77 = Color.fromRGBO(201, 54, 52, 1);

  static const c3l = Color.fromRGBO(46, 176, 134, 0.2);
  static const c3 = Color.fromRGBO(46, 176, 134, 1);
  static const c33 = Color.fromRGBO(26, 156, 114, 1);
  static const c34 = Color.fromRGBO(66, 196, 154, 1);

//연한 골드

  static const k1 = Color.fromRGBO(246, 239, 209, 1);
  static const k2 = Color.fromRGBO(236, 229, 199, 1);

  // static const nb1 = Color.fromRGBO(156, 34, 60 , 1),
  static const nb1 = Color(0xffCF0F47),
      nb12 = Color.fromRGBO(126, 4, 30, 1),
      nb13 = Color.fromRGBO(96, 0, 0, 1)
  // static const nb1 = Color.fromRGBO(250, 127, 82 , 1),
  //   nb12 = Color.fromRGBO(225, 038, 106, 1),
  //   nb13 = Color.fromRGBO(195, 8, 76, 1)
      ;
  static const n1 = Color(0xff6dddc3); //브랜드 색 (99,221,195,1)
  static const n11 = Color.fromRGBO(129, 251, 225, 1);
  static const n111 = Color.fromRGBO(129, 251, 225, 0.5);
  static const n12 = Color.fromRGBO(69, 191, 165, 1);
  static const appBarC = Color(0xfff1f1f5); //바탕
  static const n3 = Color(0xffdbdbdb); // 바탕의 바탕(플러스 버튼)
  static const n4 = Color(0xffd4d4d8); // 회색 (212,212,216)
  static const n41 = Color(0xffc9c9c9); //바텀바 비활성화
  static const ns1 = Color(0xff280000); //
  static const nt1 = Color(0xff242021); // 검은색
  static const n5 = Color(0xff21bf9b); // 홈바 액티브 (33, 191, 155, 1)
  static const n6 = Color(0xff68d9dc); // 보석 바탕색
  static const alarmC = Color(0xfffecb00);
  static const n7 = Color(0xFF64FFDA);
  static const n8 = Color(0xfffcfcfc);
  static const n9 = Color(0xff2b3A55);

  static const b1 = Color(0xff171010);
  static const b2 = Color(0xff2B2B2B);
  static const b3 = Color(0xff423F3E);
  static const b4 = Color(0xff333333);

  static const d11 = Color(0xff272E48),
      d1 = Color(0xff474E68), // 71, 78, 104
      d2 = Color(0xff3F4E4F),
      d3 = Color(0xff2c3639),
      d4 = Color(0xff444444),
      d15 = Color(0xff4B5563), // 89, 96, 122
      d5 = Color(0xff6B728E),   //107, 114, 142
      d7 = Color(0xff6B6290),
      d8 = Color.fromRGBO(231, 235, 253, 1);
// mozart: ♯E6E200 (Bright Yellow)
// maestro: #AbpColor.c5AbpColor.c5AbpColor.c5 (Light Gray)
// pro: #00BFFF (Bright Light Blue)
// Platinum: #ADAbpColor.d8E6 (Light Blue)
// Gold: #FFD700 (Yellow)
// Silver: #C0C0C0 (Gray)
// Bronze: #CD7F32 (Bronze)
// Iron: #A9A9A9 (Dark Gray)
// Unranked: #FFFFFF (White)
}


//배경 & 베이스 컬러
//
//#667EEA - 메인 배경 그라데이션 시작색 (퍼플 블루)
//#764BA2 - 메인 배경 그라데이션 끝색 (딥 퍼플)
//#FFFFFF - 카드 배경색 (순백색)
//rgba(255, 255, 255, 0.95) - 반투명 흰색 (글래스모피즘)
//🔵 토스 브랜드 컬러
//
//#0064FF - 토스 시그니처 블루 (메인 CTA)
//#4A90E2 - 라이트 블루 (보조 액센트)
//#E3F2FD - 매우 연한 블루 (배경 하이라이트)
//🟢 상태 & 성공 컬러
//
//#00C851 - 성공/증가 그린 (+12% 화살표)
//#4CAF50 - 라이트 그린 (이슈 키워드1)
//#E8F5E8 - 그린 배경 (연한 그린)
//🔴 경고 & 강조 컬러
//
//#FF4757 - 경고/중요 레드
//#FF6B6B - 소프트 레드 (이슈 키워드2)
//#FFE5E5 - 레드 배경 (연한 레드)
//⚫ 텍스트 컬러
//
//#1A1A1A - 메인 텍스트 (진한 검정)
//#333333 - 서브 헤딩 (다크 그레이)
//#666666 - 보조 텍스트 (미디엄 그레이)
//#999999 - 힌트 텍스트 (라이트 그레이)
//#CCCCCC - 비활성 텍스트 (매우 연한 그레이)
//🌈 그라데이션 컬러
//
//프로그레스 바: linear-gradient(90deg, #FF6B6B 0%, #4ECDC4 50%, #45B7D1 100%)
//카드 배경: linear-gradient(135deg, rgba(255,255,255,0.9) 0%, rgba(255,255,255,0.7) 100%)
//버튼 호버: linear-gradient(135deg, #0064FF 0%, #4A90E2 100%)
//🎯 기능별 컬러
//
//#F8F9FA - 섹션 구분선 & 보더
//#E9ECEF - 입력 필드 배경
//rgba(0, 0, 0, 0.1) - 가벼운 그림자
//rgba(0, 0, 0, 0.15) - 카드 그림자
//rgba(255, 255, 255, 0.3) - 글래스 효과
//🏷️ 태그 & 라벨 컬러
//
//#FFC107 - 경고 태그 (옐로우)
//#17A2B8 - 정보 태그 (티얼)
//#6F42C1 - 보라 태그
//#FD7E14 - 오렌지 태그

