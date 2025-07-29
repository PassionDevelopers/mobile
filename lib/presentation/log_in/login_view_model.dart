import 'dart:developer';

import 'package:could_be/core/components/alert/snack_bar.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_state.dart';

enum SignInMethod {
  google,
  apple,
  anonymous,
  kakao,
}

class LoginViewModel with ChangeNotifier {

  final FirebaseLoginUseCase _firebaseLoginUseCase;

  // 상태
  LoginState _state = LoginState();
  LoginState get state => _state;

  LoginViewModel({required FirebaseLoginUseCase firebaseLoginUseCase})
      : _firebaseLoginUseCase = firebaseLoginUseCase;

  Future<void> signIn(BuildContext context, {required SignInMethod signInMethod}) async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    try {
      if(switch(signInMethod) {
        SignInMethod.google => await _firebaseLoginUseCase.signInWithGoogle(),
        SignInMethod.apple => await _firebaseLoginUseCase.signInWithApple(),
        SignInMethod.anonymous => await _firebaseLoginUseCase.signInAnon(),
        SignInMethod.kakao => await _firebaseLoginUseCase.signInWithKakao(),
      }){
        _state = _state.copyWith(isLoginInProgress: false);
        if(context.mounted) context.go(RouteNames.root);
      }else{
        if(context.mounted) showSnackBar(context, msg: '로그인 실패: 토큰을 받지 못했습니다.');
        _state = _state.copyWith(isLoginInProgress: false);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      log(e.toString());
      if(context.mounted) showSnackBar(context, msg: '로그인 실패: 알 수 없는 오류가 발생하였습니다.');
      _state = _state.copyWith(isLoginInProgress: false);
      notifyListeners();
    }
  }


  Future<void> resignIn(BuildContext context) async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    final signInMethod = _firebaseLoginUseCase.checkSignInMethod();
    signIn(context, signInMethod: signInMethod);
  }

  Future<void> signOut() async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    await _firebaseLoginUseCase.signOut();
    _state = _state.copyWith(isLoginInProgress: false);
    notifyListeners();
  }
}