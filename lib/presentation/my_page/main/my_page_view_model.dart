
import 'dart:developer';

import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/bias_score_element.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:could_be/domain/useCases/fetch_whole_bias_score_use_case.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final FetchUserBiasUseCase _fetchUserBiasUseCase;
  final ManageUserStatusUseCase _manageUserStatusUseCase;
  final FirebaseLoginUseCase _firebaseLoginUseCase;
  final ManageUserProfileUseCase _manageUserProfileUseCase;
  final FetchWholeBiasScoreUseCase _fetchWholeBiasScoreUseCase;
  final TrackUserActivityUseCase _trackUserActivityUseCase;

  MyPageState _state = MyPageState(isGuestLogin: true);
  MyPageState get state => _state;

  MyPageViewModel({
    required FetchUserBiasUseCase fetchUserBiasUseCase,
    required ManageUserStatusUseCase manageUserStatusUseCase,
    required FirebaseLoginUseCase firebaseLoginUseCase,
    required ManageUserProfileUseCase manageUserProfileUseCase,
    required FetchWholeBiasScoreUseCase fetchWholeBiasUseCase,
    required TrackUserActivityUseCase trackUserActivityUseCase,
  }) : _fetchUserBiasUseCase = fetchUserBiasUseCase,
      _firebaseLoginUseCase = firebaseLoginUseCase,
      _manageUserProfileUseCase = manageUserProfileUseCase,
      _fetchWholeBiasScoreUseCase = fetchWholeBiasUseCase,
      _trackUserActivityUseCase = trackUserActivityUseCase,
       _manageUserStatusUseCase = manageUserStatusUseCase {
    _fetchUserBias();
    checkIsGuestLogin();
    fetchWholeBiasScore();
    fetchBiasScoreHistory();
    fetchDasiScore();
  }

  void fetchDasiScore() async {
    _state = state.copyWith(isDasiScoreLoading: true);
    notifyListeners();
    final result = await _fetchWholeBiasScoreUseCase.fetchDasiScore();
    _state = state.copyWith(
      dasiScore: result,
      isDasiScoreLoading: false,
    );
    notifyListeners();
  }

  void changeBiasNow(Bias bias) {
    _state = state.copyWith(biasNow: bias);
    notifyListeners();
  }

  void changePeriod(BiasScorePeriod period) {
    _state = state.copyWith(biasScorePeriod: period);
    fetchBiasScoreHistory();
  }

  void fetchBiasScoreHistory() async {
    _state = state.copyWith(isBiasScoreHistoryLoading: true);
    notifyListeners();
    _trackUserActivityUseCase.postUserWatchedArticles();
    final result = await _fetchWholeBiasScoreUseCase.fetchBiasScoreHistory(
        period: state.biasScorePeriod,
    );
    _state = state.copyWith(
      biasScoreHistory: result,
      isBiasScoreHistoryLoading: false,
      biasScoreHistoryLeftScores: result.leftBiasScores,
      biasScoreHistoryRightScores: result.rightBiasScores,
      biasScoreHistoryCenterScores: result.centerBiasScores,
    );
    notifyListeners();
  }

  void fetchWholeBiasScore() async {
    _state = state.copyWith(isWholeBiasScoreLoading: true);
    notifyListeners();
    _trackUserActivityUseCase.postUserWatchedArticles();
    final result = await _fetchWholeBiasScoreUseCase.fetchWholeBiasScore();
    log('fetchWholeBiasScore: $result');
    _state = state.copyWith(
      wholeBiasScore: result,
      isWholeBiasScoreLoading: false
    );
    notifyListeners();
  }

  void updateUserNickname() async {
    final name = _state.nicknameController.text.trim();
    if (!state.formKey.currentState!.validate()) {
      return;
    }
    _state = state.copyWith(isBiasLoading: true);
    notifyListeners();
    await _manageUserProfileUseCase.updateUserNickname(name);
    final result = await _fetchUserBiasUseCase.execute();
    _state = state.copyWith(
      userBias: result,
      isEditMode: false,
      isBiasLoading: false,
    );
    notifyListeners();
  }

  void setEditMode(){
    if(state.isEditMode) {
      // _state.nicknameController.clear();
    } else {
      log('setEditMode: ${state.userBias?.nickname}');
      _state.nicknameController.text = 'sdfsdfsdfsdfsdfsdfsdfsdfsd';
      // _state.nicknameController.text = state.userBias?.nickname ?? '';
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