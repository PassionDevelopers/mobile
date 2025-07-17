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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/di/di_setup.dart';
import '../../core/update_management/check_update_field.dart';
import '../../data/data_source/local/user_preferences.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late StreamSubscription fireSubscription;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

    usersStream.listen((snapshot){
      if (Platform.isAndroid) {
        if (snapshot.data()![CheckUpdateField.androidServerCheck]) {
          if(context.mounted) context.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
          if(context.mounted) context.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
          if(context.mounted) context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
        }
      } else if (Platform.isIOS) {
        if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
          if(context.mounted) context.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
          if(context.mounted) context.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
          if(context.mounted) context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.iosVersionLatest]);
        }
      } else {
        if(context.mounted) context.go(RouteNames.unsupportedDevice);
      }
    });
  }

  Future<void> userLogined(String idToken) async {
    final tokenRepo = getIt<TokenStorageRepository>();
    final trackUserActivityRepo = getIt<TrackUserActivityRepository>();
    await tokenRepo.saveToken(idToken);
    trackUserActivityRepo.postUserWatchedArticles();

    startListenUpdateStatus();

    ManageUserStatusUseCase manageUserStatusUseCase = getIt<ManageUserStatusUseCase>();
    var result = await manageUserStatusUseCase.checkUserRegisterStatus();
    if (!result.exists) {
      await manageUserStatusUseCase.registerIdToken(idToken);
      if(context.mounted) context.go(RouteNames.home);
    } else {
      if(context.mounted) context.go(RouteNames.home);
    }
  }

  void initializeNotification() async {
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

  void _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState(){
    super.initState();
    final firebaseAuth = getIt<FirebaseAuth>();
    final viewModel = getIt<LoginViewModel>();
    fireSubscription = firebaseAuth.userChanges().listen((User? user)async{
      log(firebaseAuth.currentUser.toString());
      if (user == null) {
        viewModel.signIn(context, signInMethod: SignInMethod.anonymous);
      }else{
        String? token = await firebaseAuth.currentUser!.getIdToken();
        //id token이 만료되었을때
        if(token == null){
          // 게스트 로그인 사용자이면
          if (user.isAnonymous) {
            // 리프레쉬 토큰 마저 만료되었으면 다시 게스트로 로그인
            if(user.refreshToken == null){
              viewModel.signIn(context, signInMethod: SignInMethod.anonymous);
            }else{
              //리프레쉬 토큰이 남아있으면 id token 재발급
              user.getIdToken(true);
            }
          } else {
            //게스트 로그인 사용자가 아니라면 로그인 페이지로 이동
            if(user.refreshToken == null){
              viewModel.resignIn(context);
            }else{
              //리프레쉬 토큰이 남아있으면 id token 재발급
              user.getIdToken(true);
            }
          }
        }else{
          log('login success');
          _requestPermission();
          await userLogined(token);
        }
      }
    });
  }

  @override
  void dispose(){
    fireSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
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


