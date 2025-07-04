import 'dart:developer';

import 'package:could_be/core/components/alert/snack_bar.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_state.dart';

enum SignInMethod {
  google,
  apple,
  anonymous,
}

class LoginViewModel with ChangeNotifier {

  final ManageUserStatusUseCase _manageUserStatusUseCase;

  // 상태
  LoginState _state = LoginState();
  LoginState get state => _state;

  LoginViewModel({required ManageUserStatusUseCase manageUserStatusUseCase})
      : _manageUserStatusUseCase = manageUserStatusUseCase;

  Future<void> signIn(BuildContext context, {required SignInMethod signInMethod}) async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    try {
      if(switch(signInMethod) {
        SignInMethod.google => await _manageUserStatusUseCase.signInWithGoogle(),
        SignInMethod.apple => await _manageUserStatusUseCase.signInWithApple(),
        SignInMethod.anonymous => await _manageUserStatusUseCase.signInAnon(),
      }){
        context.go(RouteNames.home);
      }else{
        showSnackBar(context, msg: '로그인 실패: 토큰을 받지 못했습니다.');
        _state = _state.copyWith(isLoginInProgress: false);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      log(e.toString());
      showSnackBar(context, msg: '로그인 실패: 알 수 없는 오류가 발생하였습니다.');
      _state = _state.copyWith(isLoginInProgress: false);
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    await _manageUserStatusUseCase.signOut();
    _state = _state.copyWith(isLoginInProgress: false);
    notifyListeners();
  }

  Future<void> signOutWithGoogle() async {
    _state = _state.copyWith(isLoginInProgress: true);
    notifyListeners();
    await _manageUserStatusUseCase.signOutWithGoogle();
    _state = _state.copyWith(isLoginInProgress: false);
    notifyListeners();
  }
}