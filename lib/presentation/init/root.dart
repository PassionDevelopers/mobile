import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/repositoryInterfaces/track_user_activity_interface.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/presentation/update_management/check_update_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/di/di_setup.dart';
import '../../data/data_source/local/user_preferences.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';
import '../../core/analytics/unified_analytics_helper.dart';

StreamSubscription? fireSubscription;

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool isRoutedToUpdate = false;

  Future startListenUpdateStatus() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
    getIt<FirebaseFirestore>().collection(CheckUpdateField.collectionName)
        .doc(CheckUpdateField.documentName)
        .snapshots();

    bool checkVersion(
        {required String currentVersion, required String newVersion}) {
      List<String> currentV = currentVersion.split(".");
      List<String> newV = newVersion.split(".");
      bool a = false;
      for (var i = 0; i < 3; i++) {
        a = int.parse(newV[i]) > int.parse(currentV[i]);
        if (int.parse(newV[i]) != int.parse(currentV[i])) break;
      }
      return a;
    }

    bool isNeedUpdate(String forceVersion, String currentVersion) {
      return checkVersion(
          currentVersion: currentVersion, newVersion: forceVersion);
    }

    bool isHaveUpdate(String latestVersion, String currentVersion) {
      // 현재 버전이 최신 버전보다 낮은지 확인
      if (checkVersion(
          currentVersion: currentVersion, newVersion: latestVersion)) {
        String? ignoredVersion = UserPreferences.getIgnoredVersion();
        // 만약 무시된 버전이 있다면, 그 버전과 최신 버전을 비교
        if (ignoredVersion != null) {
          // 무시된 버전이 현재 버전보다 높다면
          if (checkVersion(
              currentVersion: currentVersion, newVersion: ignoredVersion)) {
            // 무시된 버전과 최신 버전 비교
            return checkVersion(
                currentVersion: ignoredVersion, newVersion: latestVersion);
          }
          return true;
        }
        return true;
      }
      return false;
    }

    usersStream.listen((snapshot) {
      log('check update status ${snapshot.data()}');
      UnifiedAnalyticsHelper.logEvent(
        name: 'check_for_update',
      );
      
      if (Platform.isAndroid) {
        if (snapshot.data()![CheckUpdateField.androidServerCheck]) {
          log('서버 점검으로 가자');
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'network_error',
            parameters: {'error_type': 'server_maintenance'},
          );
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'start_update',
            parameters: {'update_type': 'force_update', 'platform': 'android'},
          );
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'start_update',
            parameters: {'update_type': 'optional_update', 'platform': 'android'},
          );
          router.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
        }
      } else if (Platform.isIOS) {
        if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'network_error',
            parameters: {'error_type': 'server_maintenance'},
          );
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'start_update',
            parameters: {'update_type': 'force_update', 'platform': 'ios'},
          );
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: 'start_update',
            parameters: {'update_type': 'optional_update', 'platform': 'ios'},
          );
          router.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.iosVersionLatest]);
        }
      } else {
        isRoutedToUpdate = true;
        router.go(RouteNames.unsupportedDevice);
      }
    });
  }

  Future<void> userLogined(String idToken) async {
    log('몇번 실행되는거냐');
    final tokenRepo = getIt<TokenStorageRepository>();
    final trackUserActivityRepo = getIt<TrackUserActivityRepository>();
    await tokenRepo.saveToken(idToken);
    trackUserActivityRepo.postUserWatchedArticles();

    startListenUpdateStatus();

    ManageUserStatusUseCase manageUserStatusUseCase = getIt<ManageUserStatusUseCase>();
    var result = await manageUserStatusUseCase.checkUserRegisterStatus();
    if (!result.exists) {
      await manageUserStatusUseCase.registerIdToken(idToken);
      log('if mounted: ${mounted}');
      if(mounted && !isRoutedToUpdate) {
        UnifiedAnalyticsHelper.logAuthEvent(
          method: 'first_time_user',
          success: true,
        );
        UnifiedAnalyticsHelper.logNavigationEvent(
          fromScreen: 'root',
          toScreen: 'home',
        );
        context.go(RouteNames.home);
      }
    } else {
      log('if mounted2: ${mounted}');
      if(mounted && !isRoutedToUpdate) {
        UnifiedAnalyticsHelper.logAuthEvent(
          method: 'returning_user',
          success: true,
        );
        UnifiedAnalyticsHelper.logNavigationEvent(
          fromScreen: 'root',
          toScreen: 'home',
        );
        context.go(RouteNames.home);
      }
    }
  }

  Future<void> initializeNotification() async {
    // await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    final channel = const AndroidNotificationChannel(
      'Dasi Stand', // id
      'High Importance Notifications', // title// description
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // icon: 'app_icon2',
              ),
            ));
      }
    });

    await messaging.setAutoInitEnabled(true);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    UnifiedAnalyticsHelper.logEvent(
      name: 'request_permission',
      parameters: {
        'permission_type': 'notifications',
        'result': settings.authorizationStatus.name
      }
    );
  }

  @override
  void initState(){
    super.initState();
    UnifiedAnalyticsHelper.logEvent(
      name: 'app_open',
    );
    UnifiedAnalyticsHelper.logScreenView(
      screenName: 'root',
      screenClass: 'Root',
    );
    
    final firebaseAuth = getIt<FirebaseAuth>();
    final viewModel = getIt<LoginViewModel>();
    fireSubscription = firebaseAuth.authStateChanges().listen((User? user)async{
      log('Auth state changed: ${user?.uid}');
      if (user == null) {
        UnifiedAnalyticsHelper.logAuthEvent(
          method: 'anonymous',
          success: true,
        );
        await viewModel.signIn(context, signInMethod: SignInMethod.anonymous);
        return;
      }
      try {
        String? token = await user.getIdToken();
        fireSubscription?.cancel();
        if(token != null){
          log('Login success - User: ${user.isAnonymous ? "Anonymous" : "Registered"}');
          UnifiedAnalyticsHelper.setUserId(user.uid);
          UnifiedAnalyticsHelper.setUserProperty(
            name: 'user_type',
            value: user.isAnonymous ? 'anonymous' : 'registered',
          );
          _requestPermission();
          await userLogined(token);
        }
      } catch (e) {
        log('Error getting ID token: $e');
        // 게스트 로그인 사용자이면
        if (user.isAnonymous) {
          UnifiedAnalyticsHelper.logEvent(
            name: 'authentication_error',
            parameters: {'error_message': 'Anonymous user token error'},
          );
          await firebaseAuth.signOut();
          await viewModel.signIn(context, signInMethod: SignInMethod.anonymous);
        }else{
          UnifiedAnalyticsHelper.logAuthEvent(
            method: 're_sign_in',
            success: false,
          );
          await viewModel.resignIn(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/images/logo/logo_rect.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}


