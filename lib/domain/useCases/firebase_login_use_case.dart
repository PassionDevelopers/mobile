import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/repositoryInterfaces/kakao_register_uuid_interface.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../repositoryInterfaces/token_storage_interface.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoAuthDataSourceImpl {
  KakaoAuthDataSourceImpl();

  User? _currentUser;

  User? get currentUser => _currentUser;

  @override
  Future<void> signOut() async {
    try {
      await UserApi.instance.logout();
      _currentUser = null;
    } catch (error) {
      return;
    }
  }

  @override
  Future<void> unlink() async {
    try {
      await UserApi.instance.unlink();
      _currentUser = null;
    } catch (error) {
      // 연결끊기 실패 시에도 로컬 상태는 초기화
      _currentUser = null;
      rethrow;
    }
  }

  @override
  bool get isSignedIn {
    return _currentUser != null;
  }

  Future<User?> _getUserInfo() async {
    try {
      _currentUser = await UserApi.instance.me();
      return _currentUser;
    } catch (error) {
      return null;
    }
  }
}

class FirebaseLoginUseCase {
  final TokenStorageRepository _tokenStorageRepository;
  final KakaoRegisterUuidRepository _kakaoRegisterUuidRepository;
  final FirebaseAuth _firebaseAuth;

  FirebaseLoginUseCase({
    required FirebaseAuth firebaseAuth,
    required TokenStorageRepository tokenStorageRepository,
    required KakaoRegisterUuidRepository kakaoRegisterUuidRepository,

  }) : _tokenStorageRepository = tokenStorageRepository,
        _kakaoRegisterUuidRepository = kakaoRegisterUuidRepository,
       _firebaseAuth = firebaseAuth;

  bool isGuest() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return true;
    }
    return user.isAnonymous;
  }

  Future<bool> saveToken(String token) async {
    return await _tokenStorageRepository.saveToken(token);
  }

  Future<bool> signInWithKakao() async {
    try {
      log("signInWithKakao called");
      log((await isKakaoTalkInstalled()).toString());
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        log("KakaoTalk is installed, trying to login with KakaoTalk");
        await UserApi.instance.loginWithKakaoAccount();
      }
      try {
        final User user = await UserApi.instance.me();
        if(user.uuid != null) _kakaoRegisterUuidRepository.registerKakaoUuid(user.uuid!);
        // OAuthToken token = user.uuid;
        // return user;
        return true;
      } catch (error) {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> signInAnon() async {
    getIt<Amplitude>().track(AmplitudeEvents.guestLogin);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        log("idToken is null");
        return false;
      } else {
        log(idToken);
        return await saveToken(idToken);
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> signInWithApple({bool? isReauth}) async {
    getIt<Amplitude>().track(AmplitudeEvents.appleLogin);
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(oauthCredential);
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        log("idToken is null");
        return false;
      } else {
        return await saveToken(idToken);
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    //계정 다시 선택하도록 연결 끊기
    // await GoogleSignIn().disconnect();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    //GoogleSignInAuthentication:Instance of 'GoogleSignInTokenData'

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    String? idToken = await userCredential.user?.getIdToken();
    // Log the event to Amplitude
    getIt<Amplitude>().track(AmplitudeEvents.googleLogin);

    if (idToken == null) {
      log("idToken is null");
      return false;
    } else {
      return await saveToken(idToken);
    }
  }

  Future<void> signOut() async {
    getIt<Amplitude>().track(AmplitudeEvents.signOut);
    await FirebaseAuth.instance.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }
  }

  SignInMethod checkSignInMethod() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return SignInMethod.anonymous;
    }
    if (user.isAnonymous) {
      return SignInMethod.anonymous;
    }
    String? providerId =
        user.providerData.isNotEmpty
            ? user.providerData.first.providerId
            : null;
    if (providerId == 'google.com') {
      return SignInMethod.google;
    } else if (providerId == 'apple.com') {
      return SignInMethod.apple;
    }
    return SignInMethod
        .anonymous; // Default to anonymous if no provider matches
  }

  Future<void> deleteUserAccount(BuildContext context) async {
    getIt<Amplitude>().track(AmplitudeEvents.deleteUserAccount);
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      log("No user is currently signed in.");
      return;
    }

    String? providerId =
        user.providerData.isNotEmpty
            ? user.providerData.first.providerId
            : null;
    log("Provider ID: $providerId");
    if (providerId == 'google.com') {
      await _deleteUserGoogle(context);
    } else if (providerId == 'apple.com') {
      await _deleteUserApple(context);
    } else if (providerId == null) {
      await _deleteUserAnon(context);
    } else {
      log("Unsupported provider: $providerId");
    }
  }

  Future<void> _deleteUserGoogle(BuildContext context) async {
    if (await GoogleSignIn().isSignedIn()) {
      await reauthWithGoogle();
      _deleteUserFromFirebase(context);
    } else {
      if (context.mounted)
        showAlert(msg: '앱에 가입할때 사용한 계정을 선택해 주시기 바랍니다.', context: context);
    }
  }

  Future<void> _deleteUserApple(BuildContext context) async {
    if (await SignInWithApple.isAvailable()) {
      await reauthWithApple();
      _deleteUserFromFirebase(context);
    } else {
      if (context.mounted)
        showAlert(msg: '앱에 가입할때 사용한 계정을 선택해 주시기 바랍니다.', context: context);
    }
  }

  Future<void> _deleteUserAnon(BuildContext context) async {
    _deleteUserFromFirebase(context);
  }

  Future<void> _deleteUserFromFirebase(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().disconnect();
      }
      if (!context.mounted) return;
      showAlert(msg: '계정이 삭제되었습니다. 그동안 함께해주셔서 감사합니다.', context: context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await FirebaseAuth.instance.signOut();
        if (await GoogleSignIn().isSignedIn()) {
          await GoogleSignIn().disconnect();
        }
        if (!context.mounted) return;
        showAlert(
          msg: '마지막 로그인 후 시간이 오래지났습니다. 계정을 삭제하시려면 다시 로그인한 뒤 재시도하시기 바랍니다.',
          context: context,
        );
      }
    }
    if (context.mounted) context.go(RouteNames.root);
  }

  // Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
  //   return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  // }
  //
  Future<UserCredential?> reauthWithApple({bool? isReauth}) async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(oauthCredential);
  }

  //
  Future<UserCredential?> reauthWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(credential);
  }

  //
  // Future<void> deleteUser()async{
  //   await _tokenStorageRepository.clearToken();
  //   _manageUserStatusRepository.deleteUser();
  // }
}
