import 'package:could_be/core/routes/router.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

import 'core/behavior/scroll_behavior.dart';
import 'core/themes/app_bar_theme.dart';
import 'core/themes/bottom_navigation_bar_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays:[]
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sample',
      scrollBehavior: MyBehavior(),
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // brightness: Brightness.light,
        // cardColor: Colors.white,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary, brightness: Brightness.light,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: MyAppBarTheme(),
        cardTheme: CardThemeData(
          color: Colors.white
        ),
        tabBarTheme: TabBarThemeData(
          dividerColor: Colors.transparent,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: MyBottomNavigationBarTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      // themeMode: ThemeMode.system,
    );
  }
} 