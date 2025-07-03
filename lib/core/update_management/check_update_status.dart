import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/update_management/check_update_field.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckUpdateStatus extends StatelessWidget {
  const CheckUpdateStatus({super.key});



  Future startListenMailBox(
      String version, int publicMailNumber, Function updateMail, BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
