import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/di/di_setup.dart';
import '../../core/update_management/check_update_field.dart';
import '../../data/data_source/local/user_preferences.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';
import '../home/home_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late StreamSubscription fireSubscription;

  Future startListenUpdateStatus(String version, BuildContext context) async {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
    FirebaseFirestore.instance.collection(CheckUpdateField.collectionName)
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
          context.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
          context.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
          context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
        }
      } else if (Platform.isIOS) {
        if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
          context.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
          context.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
          context.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.iosVersionLatest]);
        }
      } else {
        context.go(RouteNames.unsupportedDevice);
      }
    });
  }

  Map<String, List<int>> typeCasting(Map data) {
    List keys = data.keys.toList();
    List values = data.values.toList();
    Map<String, List<int>> result = {};
    for (int i = 0; i < keys.length; i++) {
      result['${keys[i]}'] = values[i].cast<int>();
    }
    return result;
  }

  Future<void> userLogined(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String? idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final tokenRepo = getIt<TokenStorageRepository>();
    if (idToken == null) {
      log('idToken is null');
      context.go(RouteNames.login);
      return;
    }
    await tokenRepo.saveToken(idToken);

    startListenUpdateStatus(version, context);

    ManageUserStatusUseCase manageUserStatusUseCase = getIt<ManageUserStatusUseCase>();

    var result = await manageUserStatusUseCase.checkUserRegisterStatus();
    if (!result.exists) {
      await manageUserStatusUseCase.registerIdToken(idToken);
      context.go(RouteNames.home);
    } else {
      context.go(RouteNames.home);
    }
  }

  @override
  void initState(){
    super.initState();

    fireSubscription = FirebaseAuth.instance.userChanges().listen((User? user)async{
      log(FirebaseAuth.instance.currentUser.toString());
      if (user == null) {
        context.go(RouteNames.login);
        log('User is null');
      }else{
        if (FirebaseAuth.instance.currentUser == null) {
          context.go(RouteNames.login);
          log('FirebaseAuth.instance.currentUser is null');
        } else {
          String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
          if(token == null){
            context.go(RouteNames.login);
            log('FirebaseAuth.instance.currentUser!.getIdToken() is null');
          }else{
            log('${token}');
            await userLogined(context);
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
    return MyScaffold(body: Center(
      child: Text('root'),
    ));
  }
}


