import 'dart:async';
import 'package:could_be/core/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late StreamSubscription fireSubscription;

  @override
  void initState(){
    super.initState();

    fireSubscription = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        context.go(RouteNames.login);
      }else{
        if (FirebaseAuth.instance.currentUser == null) {
          context.go(RouteNames.login);
        } else {
          context.go(RouteNames.home);
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
    return const Placeholder();
  }
}

// class UserLogined extends StatelessWidget {
//   const UserLogined({Key? key}) : super(key: key);
//
//   Future startListenUpdateStatus(
//       String version, int publicMailNumber, Function updateMail, BuildContext context) async {
//     final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
//     FirebaseFirestore.instance.collection(CheckUpdateField.collectionName)
//         .doc(CheckUpdateField.documentName)
//         .snapshots();
//
//     bool checkVersion(
//         {required String currentVersion, required String newVersion}) {
//       List<String> currentV = currentVersion.split(".");
//       List<String> newV = newVersion.split(".");
//       bool a = false;
//       for (var i = 0; i < 3; i++) {
//         a = int.parse(newV[i]) > int.parse(currentV[i]);
//         if (int.parse(newV[i]) != int.parse(currentV[i])) break;
//       }
//       return a;
//     }
//
//     bool isNeedUpdate(String forceVersion, String currentVersion) {
//       return checkVersion(
//           currentVersion: currentVersion, newVersion: forceVersion);
//     }
//
//     bool isHaveUpdate(String latestVersion, String currentVersion) {
//       // 현재 버전이 최신 버전보다 낮은지 확인
//       if (checkVersion(
//           currentVersion: currentVersion, newVersion: latestVersion)) {
//         String? ignoredVersion = UserPreferences.getIgnoredVersion();
//         // 만약 무시된 버전이 있다면, 그 버전과 최신 버전을 비교
//         if (ignoredVersion != null) {
//           // 무시된 버전이 현재 버전보다 높다면
//           if (checkVersion(
//               currentVersion: currentVersion, newVersion: ignoredVersion)) {
//             // 무시된 버전과 최신 버전 비교
//             return checkVersion(
//                 currentVersion: ignoredVersion, newVersion: latestVersion);
//           }
//           return true;
//         }
//         return true;
//       }
//       return false;
//     }
//
//     usersStream.listen((snapshot){
//       if (Platform.isAndroid) {
//         if (snapshot.data()![CheckUpdateField.androidServerCheck]) {
//           context.go(RouteNames.serverCheck);
//         } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
//           context.go(RouteNames.needUpdate);
//         } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
//           context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
//         }
//       } else if (Platform.isIOS) {
//         if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
//           context.go(RouteNames.serverCheck);
//         } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
//           context.go(RouteNames.needUpdate);
//         } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
//           context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.iosVersionLatest]);
//         }
//       } else {
//         context.go(RouteNames.unsupportedDevice);
//       }
//     });
//   }
//
//   Map<String, List<int>> typeCasting(Map data) {
//     List keys = data.keys.toList();
//     List values = data.values.toList();
//     Map<String, List<int>> result = {};
//     for (int i = 0; i < keys.length; i++) {
//       result['${keys[i]}'] = values[i].cast<int>();
//     }
//     return result;
//   }
//
//   Future<Widget> userLogined(context) async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String version = packageInfo.version;
//
//     // startListenUpdateStatus(version, publicMailNumber, updateMail, context);
//     //
//     // String uid = FirebaseAuth.instance.currentUser!.uid;
//     //
//     // var result = await FirebaseFirestore.instance
//     //     .collection(Collections.userInfo)
//     //     .doc(uid)
//     //     .get();
//     // if (!result.exists) {
//     //   // 사용자 정보가 디비에 없다면 = 처음 가입했어요
//     //   return const Nickname();
//     // } else {
//     //   //사용자 정보가 디비에 이미 있으면
//     //   Map<String, dynamic> resultData = result.data()!;
//     //   if (!resultData.containsKey('nickname')) {
//     //     //nickname 안정했냐
//     //     return const Nickname();
//     //   } else {
//     //     // FCM 초기화
//     //     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     //     await messaging.setAutoInitEnabled(true);
//     //     // _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     //     //
//     //     // await messaging.setForegroundNotificationPresentationOptions(
//     //     //   alert: true,
//     //     //   badge: true,
//     //     //   sound: true,
//     //     // );
//     //     NotificationSettings settings = await messaging.requestPermission(
//     //       alert: true,
//     //       announcement: false,
//     //       badge: true,
//     //       carPlay: false,
//     //       criticalAlert: false,
//     //       provisional: false,
//     //       sound: true,
//     //     );
//     //     final fcmToken = await FirebaseMessaging.instance.getToken();
//     //     if (settings.authorizationStatus == AuthorizationStatus.authorized &&
//     //         fcmToken != null) {
//     //       print('FCM Token: $fcmToken');
//     //     } else {
//     //       print('FCM Token: null');
//     //     }
//     //
//     //     return const MyApp();
//     //   }
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return scaffold(
//       body: FutureBuilder<Widget>(
//         future: userLogined(context),
//         builder: (BuildContext context, AsyncSnapshot<Widget> snapshot2) {
//           if (snapshot2.connectionState == ConnectionState.done) {
//             if (snapshot2.hasError) {
//               snapshot2.printError();
//               return Center(
//                 child: Text('Error 5 : $errorMessage \n($developerAdress)'),
//               );
//             }
//             if (snapshot2.hasData) {
//               return snapshot2.data!;
//             }
//           }
//           return const TigerLoading();
//         },
//       ),
//     );
//   }
// }

