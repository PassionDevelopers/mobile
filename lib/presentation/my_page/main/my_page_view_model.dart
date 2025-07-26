
import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
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

  final _eventController = StreamController<NickNameError>();

  Stream<NickNameError> get eventStream => _eventController.stream;

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

  void changeHexagonZoom(bool isAbsolute) {
    _state = state.copyWith(isHexagonAbsolute: isAbsolute);
    notifyListeners();
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

    double findMax(List<double> a, List<double> b, List<double> c) {
      double maxValue = double.negativeInfinity;

      for (var list in [a, b, c]) {
        for (var value in list) {
          if (value > maxValue) maxValue = value;
        }
      }
      return maxValue;
    }
    _trackUserActivityUseCase.postUserWatchedArticles();
    final result = await _fetchWholeBiasScoreUseCase.fetchBiasScoreHistory(
        period: state.biasScorePeriod,
    );
    final List<double> leftBiasScores = result.leftBiasScores;
    final List<double> centerBiasScores = result.centerBiasScores;
    final List<double> rightBiasScores = result.rightBiasScores;
    final double maxBiasScore = findMax(
      leftBiasScores,
      centerBiasScores,
      rightBiasScores
    );
    _state = state.copyWith(
      biasScoreHistory: result,
      isBiasScoreHistoryLoading: false,
      biasScoreHistoryLeftScores: leftBiasScores,
      biasScoreHistoryRightScores: rightBiasScores,
      biasScoreHistoryCenterScores: centerBiasScores,
      maxBiasScore: maxBiasScore,
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
    final nickNameResult = await _manageUserProfileUseCase.updateUserNickname(name);
    log('updateUserNickname: $nickNameResult');
    switch(nickNameResult) {
      case ResultSuccess<bool, NickNameError> success:
        _state = state.copyWith(
          isEditMode: false,
          isBiasLoading: false,
        );
        final result = await _fetchUserBiasUseCase.execute();
        _state = state.copyWith(
          userBias: result,
          isEditMode: false,
          isBiasLoading: false,
        );
        notifyListeners();
      case ResultError<bool, NickNameError> error:
        _state = state.copyWith(
          isBiasLoading: false,
        );
        _eventController.add(error.error);
        notifyListeners();
    }
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