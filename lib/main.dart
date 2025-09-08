import 'dart:async';
import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:could_be/constants.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/ui/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'core/analytics/analytics_event_names.dart';
import 'core/analytics/unified_analytics_helper.dart';
import 'core/behavior/scroll_behavior.dart';
import 'core/themes/app_bar_theme.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConstants.initialize(Environment.prod);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays:[]
  // );
  // await UserSimplePreferences.init();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //
  //   // RemoteNotification notification = message.notification;
  //   // AndroidNotification android = message.notification?.android;
  //   //
  //   // if (notification != null && android != null) {
  //   //   flutterLocalNotificationsPlugin.show(
  //   //       notification.hashCode,
  //   //       notification.title,
  //   //       notification.body,
  //   //       NotificationDetails(
  //   //         android: AndroidNotificationDetails(
  //   //           channel.id,
  //   //           channel.name,
  //   //           channel.description,
  //   //           // TODO add a proper drawable resource to android, for now using
  //   //           //      one that already exists in example app.
  //   //           icon: 'launch_background',
  //   //         ),
  //   //       ));
  //   // }
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });

  await UserPreferences.init();
  KakaoSdk.init(nativeAppKey: EnvConstants.kakaoNativeAppKey);

  final config = ClarityConfig(
    projectId: EnvConstants.clarityApiKey,
    logLevel: LogLevel.None, // Note: Use "LogLevel.Verbose" value while testing to debug initialization issues.
  );

  await diSetupToken();
  await diSetup();
  
  runApp(ClarityWidget(app: const MyApp(), clarityConfig: config));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.appOpen,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.appTerminate,
    );
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.appForeground,
        );
        break;
      case AppLifecycleState.paused:
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.appBackground,
        );
        break;
      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
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
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: MyAppBarTheme(),
        cardTheme: CardThemeData(color: Colors.white),
        tabBarTheme: TabBarThemeData(
          dividerColor: Colors.transparent,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
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
