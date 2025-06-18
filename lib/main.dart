import 'package:could_be/presentation/behavior/scroll_behavior.dart';
import 'package:could_be/presentation/home/home_view.dart';
import 'package:could_be/presentation/routes/get_route_names.dart';
import 'package:could_be/presentation/themes/app_bar_theme.dart';
import 'package:could_be/presentation/themes/bottom_navigation_bar_theme.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/presentation/views/blind_home_view.dart';
import 'package:could_be/presentation/views/login_view.dart';
import 'package:could_be/presentation/views/media_bias_view.dart';
import 'package:could_be/presentation/views/myPage/my_page_view.dart';
import 'package:could_be/presentation/views/shorts_view.dart';
import 'package:could_be/presentation/views/topic_detail_view.dart';
import 'package:could_be/presentation/views/topic_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

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
    return GetMaterialApp(
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
      getPages: [
        GetPage(name: RouteNames.home, page: ()=> HomeView(), transition: Transition.noTransition),
        GetPage(name: RouteNames.shortsView, page: ()=> ShortsView(), transition: Transition.noTransition),
        GetPage(name: RouteNames.topic, page: ()=> TopicHomeView(), transition: Transition.noTransition),
        GetPage(name: RouteNames.topicDetail, page: ()=> TopicDetailView(), transition: Transition.noTransition),
        GetPage(name: RouteNames.blindSpot, page: ()=> BlindHomeView(), transition: Transition.noTransition),
        GetPage(name: RouteNames.mediaBias, page: ()=> MediaBiasView(), transition: Transition.noTransition),
        // GetPage(name: RouteNames.feed, page: ()=> IssueView()),
        GetPage(name: RouteNames.myPage, page: ()=> MyPageView(), transition: Transition.noTransition),
        // GetPage(name: RouteNames.loading, page: ()=> NewsApp()),

      ],
      // themeMode: ThemeMode.system,
      home: LoginView(),
    );
  }
} 