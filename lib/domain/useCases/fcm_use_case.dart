import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_fcm_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class FcmUseCase{

  final ManageFcmRepository fcmRepository;

  FcmUseCase(this.fcmRepository);

  Future<void> initializeNotification() async {
    // await Firebase.initializeApp();
    final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    final fcmToken = await messaging.getToken();
    final fcmRepository = getIt<ManageFcmRepository>();
    if(fcmToken != null) await fcmRepository.updateFcmToken(fcmToken);
    final channel = const AndroidNotificationChannel(
      'Dasi Stand', // id
      'High Importance Notifications', // title// description
      importance: Importance.defaultImportance,
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

    // await messaging.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: false,
    // );
  }

  Future<void> updateFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final fcmToken = await messaging.getToken();
    final fcmRepository = getIt<ManageFcmRepository>();
    if(fcmToken != null) await fcmRepository.updateFcmToken(fcmToken);
  }

  Future<void> initListeners(BuildContext context) async {
    //push 알림 권한 얻기
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) return;

    // // //1. 어플이 열려있을 때 Push 알림(Foreground)
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("foreground message");
    //   if(event.data.containsKey("issueId")){
    //     String issueId = event.data["issueId"];
    //     context.push('${RouteNames.issueDetailFeed}/$issueId');
    //     return;
    //   }
    // });

    //2. 어플이 닫혀있을 때 Push 알림(Background)
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //Push 알림에 data를 추가로 보내고 이를 받아올 수 있음
      //print(event.data["screen"]);
      if(event.data.containsKey("issueId")){
        String issueId = event.data["issueId"];
        context.push('${RouteNames.issueDetailFeed}/$issueId');
        return;
      }
    });

    //3. 앱이 종료된 상태에서의 Push 알림 (Terminated)
    final notification = await _messaging.getInitialMessage();
    if (notification == null) return;
    //print(notification.data["screen"]);
    if(notification.data.containsKey("issueId")){
      String issueId = notification.data["issueId"];
      context.push('${RouteNames.issueDetailFeed}/$issueId');
      return;
    }
  }


}