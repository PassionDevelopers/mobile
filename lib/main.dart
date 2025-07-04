import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/domain/error_view.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/root.dart';
import 'package:could_be/splash_screen.dart';
import 'package:could_be/ui/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'core/behavior/scroll_behavior.dart';
import 'core/themes/app_bar_theme.dart';
import 'core/themes/bottom_navigation_bar_theme.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  // KakaoSdk.init(nativeAppKey: 'c0f1b2d3e4f5g6h7i8j9k0l1m2n3o4p5'); // 카카오 SDK 초기화

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays:[]
  // );
  // await UserSimplePreferences.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    // RemoteNotification notification = message.notification;
    // AndroidNotification android = message.notification?.android;
    //
    // if (notification != null && android != null) {
    //   flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channel.description,
    //           // TODO add a proper drawable resource to android, for now using
    //           //      one that already exists in example app.
    //           icon: 'launch_background',
    //         ),
    //       ));
    // }
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  //의존성 주입

  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreen()); // 초기 로딩 시 Splash Screen
        } else if (snapshot.hasError) {
          return MaterialApp(home: ErrorView()); // 초기 로딩 에러 시 Error Screen
        } else {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: '다시 스탠드',
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
      },
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future<Widget?> initialize(BuildContext context) async {
    // await Future.delayed(Duration(milliseconds: 1000));

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return Root(); // 초기 로딩 완료 시 띄울 앱 첫 화면
  }
}