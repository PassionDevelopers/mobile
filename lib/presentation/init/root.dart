import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      log('update stream : ${snapshot.data()}');
      if (Platform.isAndroid) {
        if (snapshot.data()![CheckUpdateField.androidServerCheck]) {
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
          router.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
        }
      } else if (Platform.isIOS) {
        if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
          router.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.iosVersionLatest]);
        }
      } else {
        router.go(RouteNames.unsupportedDevice);
      }
    });
  }

  Future<void> userLogined() async {
    String? idToken = await getIt<FirebaseAuth>().currentUser!.getIdToken();
    final tokenRepo = getIt<TokenStorageRepository>();
    if (idToken == null) {
      log('idToken is null');
      router.go(RouteNames.login);
      return;
    }
    await tokenRepo.saveToken(idToken);

    startListenUpdateStatus();

    ManageUserStatusUseCase manageUserStatusUseCase = getIt<ManageUserStatusUseCase>();
    var result = await manageUserStatusUseCase.checkUserRegisterStatus();
    if (!result.exists) {
      await manageUserStatusUseCase.registerIdToken(idToken);
      router.go(RouteNames.home);
    } else {
      router.go(RouteNames.home);
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

    fireSubscription = FirebaseAuth.instance.userChanges().listen((User? user)async{
      log(FirebaseAuth.instance.currentUser.toString());
      if (user == null) {
        router.go(RouteNames.login);
        log('User is null');
      }else{
        if (FirebaseAuth.instance.currentUser == null) {
          router.go(RouteNames.login);
          log('FirebaseAuth.instance.currentUser is null');
        } else {
          String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
          if(token == null){
            router.go(RouteNames.login);
            log('FirebaseAuth.instance.currentUser!.getIdToken() is null');
          }else{
            log('${token}');
            _requestPermission();
            await userLogined();
          }
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


