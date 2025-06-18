

import 'package:flutter/material.dart';

import '../../ui/color.dart';

class MyBottomNavigationBarTheme extends BottomNavigationBarThemeData {
  MyBottomNavigationBarTheme()
      : super(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.secondary,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );
}