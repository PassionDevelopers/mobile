

import 'package:flutter/material.dart';

import 'color.dart';

class MyAppBarTheme extends AppBarTheme {
  MyAppBarTheme()
      : super(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.primaryLight,
    foregroundColor: AppColors.primary,
  );
}