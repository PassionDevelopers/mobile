
import 'dart:developer';

import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final FetchUserBiasUseCase _fetchUserBiasUseCase;
  final ManageUserStatusUseCase _manageUserStatusUseCase;
  final FirebaseLoginUseCase _firebaseLoginUseCase;
  final ManageUserProfileUseCase _manageUserProfileUseCase;

  MyPageState _state = MyPageState(isGuestLogin: true);
  MyPageState get state => _state;

  MyPageViewModel({
    required FetchUserBiasUseCase fetchUserBiasUseCase,
    required ManageUserStatusUseCase manageUserStatusUseCase,
    required FirebaseLoginUseCase firebaseLoginUseCase,
    required ManageUserProfileUseCase manageUserProfileUseCase,
  }) : _fetchUserBiasUseCase = fetchUserBiasUseCase,
      _firebaseLoginUseCase = firebaseLoginUseCase,
      _manageUserProfileUseCase = manageUserProfileUseCase,
       _manageUserStatusUseCase = manageUserStatusUseCase {
    _fetchUserBias();
    checkIsGuestLogin();
  }

  void updateUserNickname() async {
    final name = _state.nicknameController.text.trim();
    if(name.isEmpty) {
      log('닉네임이 비어있습니다.');
      return;
    }
    _state = state.copyWith(isBiasLoading: true);
    notifyListeners();
    await _manageUserProfileUseCase.updateUserNickname(name);
    _fetchUserBias();
  }

  void setEditMode(){
    if(state.isEditMode) {
      _state.nicknameController.clear();
    } else {
      _state.nicknameController.text = state.userBias?.nickname ?? '';
    }
    _state = state.copyWith(isEditMode: !state.isEditMode);
    notifyListeners();
  }

  void setIsGuestLogin(){
    _state = state.copyWith(isGuestLogin: false);
    log('set isGuestLogin: ${_state.isGuestLogin}');
    notifyListeners();
  }

  void checkIsGuestLogin() {
    _state = state.copyWith(isGuestLogin: _firebaseLoginUseCase.isGuest());
    log('isGuestLoginReal: ${_state.isGuestLogin}');
    notifyListeners();
  }

  void _fetchUserBias() async{
    _state = state.copyWith(isBiasLoading: true);
    notifyListeners();
    final result = await _fetchUserBiasUseCase.execute();

    _state = state.copyWith(
      userBias: result,
      isBiasLoading: false,
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    _state = state.copyWith(isUserStatusLoading: true);
    notifyListeners();
    await _firebaseLoginUseCase.signOut();
    _state = state.copyWith(isUserStatusLoading: false);
  }

  Future<void> deleteAccount(BuildContext context) async {
    _state = state.copyWith(isUserStatusLoading: true);
    notifyListeners();
    await _manageUserStatusUseCase.deleteUserAccount();
    await _firebaseLoginUseCase.deleteUserAccount(context);
    _state = state.copyWith(isUserStatusLoading: false);
    notifyListeners();
  }
}