class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();
  
  // 브레이크포인트 정의
  static const double mobile = 768;
  static const double tablet = 924;
  static const double smallDesktop = 1100; // 태블릿과 동일하게 처리
  static const double desktop = 1200;
  
  // 최대 컨텐츠 너비
  static const double maxContentWidth = 1200;
  static const double maxMobileContentWidth = 600;
  
  // 그리드 관련
  static const int mobileColumns = 1;
  static const int tabletColumns = 1;
  static const int smallDesktopColumns = 2;
  static const int desktopColumns = 3;
  
  // 네비게이션 관련
  static const double sidebarWidth = 280;
  static const double sidebarCollapsedWidth = 80;
}

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

enum ResponsiveGridType {
  staggered,
  fixed,
  adaptive,
}