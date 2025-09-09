import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/permission/permission_management.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/repositoryInterfaces/logging/track_user_activity_interface.dart';
import 'package:could_be/domain/useCases/fcm_use_case.dart';
import 'package:could_be/domain/useCases/user/manage_user_status_use_case.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/presentation/update_management/check_update_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/analytics/analytics_event_names.dart';
import '../../core/analytics/unified_analytics_helper.dart';
import '../../core/di/di_setup.dart';
import '../../data/data_source/local/user_preferences.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';

StreamSubscription? fireSubscription;

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

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
        name: AnalyticsEventNames.checkForUpdate,
      );
      
      if (Platform.isAndroid) {
        if (snapshot.data()![CheckUpdateField.androidServerCheck]) {
          log('서버 점검으로 가자');
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.networkError,
            parameters: {'error_type': 'server_maintenance'},
          );
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.androidVersionForce], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.startUpdate,
            parameters: {'update_type': 'force_update', 'platform': 'android'},
          );
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.androidVersionLatest], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.startUpdate,
            parameters: {'update_type': 'optional_update', 'platform': 'android'},
          );
          router.go(RouteNames.haveUpdate, extra: snapshot.data()![CheckUpdateField.androidVersionLatest]);
        }
      } else if (Platform.isIOS) {
        if (snapshot.data()![CheckUpdateField.iosServerCheck]) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.networkError,
            parameters: {'error_type': 'server_maintenance'},
          );
          router.go(RouteNames.serverCheck);
        } else if (isNeedUpdate(snapshot.data()![CheckUpdateField.iosVersionForce], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.startUpdate,
            parameters: {'update_type': 'force_update', 'platform': 'ios'},
          );
          router.go(RouteNames.needUpdate);
        } else if (isHaveUpdate(snapshot.data()![CheckUpdateField.iosVersionLatest], version)) {
          isRoutedToUpdate = true;
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.startUpdate,
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
    bool isFirstLaunch = UserPreferences.getIsFirstLaunchApp() ?? true;
    if (!result.exists) {
      String? guestUid = await tokenRepo.getGuestUid();
      await manageUserStatusUseCase.registerIdToken(guestUid: guestUid);
      if (mounted && !isRoutedToUpdate) {
        UnifiedAnalyticsHelper.logAuthEvent(
          method: 'first_time_user',
          success: true,
        );
        context.go(RouteNames.onboarding);
      }
    }else if(isFirstLaunch) {
      if (mounted && !isRoutedToUpdate) {
        UnifiedAnalyticsHelper.logAuthEvent(
          method: '기존 사용자 첫 온보딩',
          success: true,
        );
        UserPreferences.setIsFirstLaunchApp(false);
        context.go(RouteNames.onboarding);
      }
    } else {
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

  @override
  void initState(){
    super.initState();
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.appOpen,
    );
    
    final firebaseAuth = getIt<FirebaseAuth>();
    final viewModel = getIt<LoginViewModel>();
    final fcmUseCase = getIt<FcmUseCase>();
    fcmUseCase.updateFcmToken();
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
          requestFCMPermission(true);
          await userLogined(token);
        }
      } catch (e) {
        log('Error getting ID token: $e');
        // 게스트 로그인 사용자이면
        if (user.isAnonymous) {
          UnifiedAnalyticsHelper.logEvent(
            name: AnalyticsEventNames.authenticationError,
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


