import 'package:flutter/material.dart';
import 'responsive_constants.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  // 디바이스 타입 결정
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  // 화면 너비 가져오기
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // 화면 높이 가져오기
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // 모바일 여부 확인
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < ResponsiveBreakpoints.mobile;
  }

  // 태블릿 여부 확인
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= ResponsiveBreakpoints.mobile && 
           width < ResponsiveBreakpoints.tablet;
  }

  // 작은 데스크탑 여부 확인
  static bool isSmallDesktop(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= ResponsiveBreakpoints.tablet &&
           width < ResponsiveBreakpoints.desktop;
  }

  // 데스크탑 여부 확인
  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= ResponsiveBreakpoints.tablet;
  }

  // 사이드바 사용 여부 결정
  static bool shouldUseSidebar(BuildContext context) {
    return isDesktop(context);
  }

  // 그리드 컬럼 수 결정
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return ResponsiveBreakpoints.mobileColumns;
    } else if (isTablet(context)) {
      return ResponsiveBreakpoints.tabletColumns;
    } else {
      return ResponsiveBreakpoints.desktopColumns;
    }
  }

  // 컨텐츠 최대 너비 계산
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return ResponsiveBreakpoints.maxMobileContentWidth;
    }
    return ResponsiveBreakpoints.maxContentWidth;
  }

  // 반응형 패딩 계산
  static EdgeInsets getResponsivePadding(BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    if (isMobile(context)) {
      return EdgeInsets.all(mobile);
    } else if (isTablet(context)) {
      return EdgeInsets.all(tablet);
    } else {
      return EdgeInsets.all(desktop);
    }
  }

  // 반응형 마진 계산
  static EdgeInsets getResponsiveMargin(BuildContext context, {
    double mobile = 8.0,
    double tablet = 16.0,
    double desktop = 24.0,
  }) {
    if (isMobile(context)) {
      return EdgeInsets.all(mobile);
    } else if (isTablet(context)) {
      return EdgeInsets.all(tablet);
    } else {
      return EdgeInsets.all(desktop);
    }
  }

  // 반응형 폰트 사이즈 계산
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // 카드 크기 계산
  static Size getCardSize(BuildContext context, {
    Size? mobile,
    Size? tablet,
    Size? desktop,
  }) {
    if (isMobile(context)) {
      return mobile ?? const Size(double.infinity, 200);
    } else if (isTablet(context)) {
      return tablet ?? const Size(300, 250);
    } else {
      return desktop ?? const Size(350, 300);
    }
  }
}