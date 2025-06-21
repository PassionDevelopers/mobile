

import 'package:flutter/material.dart';

import '../../ui/color.dart';

class MyBottomNavigationBarTheme extends BottomNavigationBarThemeData {
  MyBottomNavigationBarTheme()
      : super(
    backgroundColor: Colors.white.withOpacity(0.9),
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.textSecondary,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 11,
    ),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  );
}

// Modern bottom navigation theme for the new custom widget
class ModernBottomNavigationTheme {
  static const double height = 75;
  static const double borderRadius = 25;
  static const double iconSize = 24;
  static const double selectedIconScale = 1.2;
  
  static final BoxShadow primaryShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 20,
    offset: Offset(0, 10),
  );
  
  static final BoxShadow accentShadow = BoxShadow(
    color: AppColors.accent.withOpacity(0.05),
    blurRadius: 40,
    offset: Offset(0, 20),
  );
  
  static final Color backgroundColor = Colors.white.withOpacity(0.9);
  static final Color borderColor = Colors.white.withOpacity(0.2);
}