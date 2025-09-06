import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/core/events/profile_events.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';
import 'package:could_be/domain/useCases/whole_bias_score_use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final ManageUserStatusUseCase _manageUserStatusUseCase;
  final FirebaseLoginUseCase _firebaseLoginUseCase;
  final ManageUserProfileUseCase _manageUserProfileUseCase;
  final WholeBiasScoreUseCase _fetchWholeBiasScoreUseCase;
  final TrackUserActivityUseCase _trackUserActivityUseCase;

  final _eventController = StreamController<NickNameError>();

  Stream<NickNameError> get eventStream => _eventController.stream;
  StreamSubscription<String?>? _profileStreamSubscription;

  MyPageState _state = MyPageState(isGuestLogin: true);
  MyPageState get state => _state;

  MyPageViewModel({
    required ManageUserStatusUseCase manageUserStatusUseCase,
    required FirebaseLoginUseCase firebaseLoginUseCase,
    required ManageUserProfileUseCase manageUserProfileUseCase,
    required WholeBiasScoreUseCase fetchWholeBiasUseCase,
    required TrackUserActivityUseCase trackUserActivityUseCase,
  }) : _firebaseLoginUseCase = firebaseLoginUseCase,
      _manageUserProfileUseCase = manageUserProfileUseCase,
      _fetchWholeBiasScoreUseCase = fetchWholeBiasUseCase,
      _trackUserActivityUseCase = trackUserActivityUseCase,
       _manageUserStatusUseCase = manageUserStatusUseCase {
    _fetchUserProfile();
    checkIsGuestLogin();
    fetchWholeBiasScore();
    fetchBiasScoreHistory();
    fetchDasiScore();
    _setupProfileListener();
  }

  void _setupProfileListener(){
    _profileStreamSubscription = ProfileEvents.profileStream.listen((imageUrl) {
        _state = state.copyWith(
          userProfile: state.userProfile?.copyWith(clearImage : imageUrl == null, imageUrl: imageUrl),
        );
        notifyListeners();
      },
    );
  }

  void refresh() {
    _fetchUserProfile();
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

    double findMin(List<double> a, List<double> b, List<double> c) {
      double minValue = double.infinity;

      for (var list in [a, b, c]) {
        for (var value in list) {
          if (value < minValue && value > 0) minValue = value;
        }
      }
      return minValue;
    }
    _trackUserActivityUseCase.postUserWatchedArticles();
    final result = await _fetchWholeBiasScoreUseCase.fetchBiasScoreHistory(
        period: state.biasScorePeriod,
    );
    final List<double> leftBiasScores = result.leftBiasScores;
    final List<double> centerBiasScores = result.centerBiasScores;
    final List<double> rightBiasScores = result.rightBiasScores;

    log("Bias Score History fetched: Left - $leftBiasScores, Center - $centerBiasScores, Right - $rightBiasScores");

    final double maxBiasScore = findMax(
      leftBiasScores,
      centerBiasScores,
      rightBiasScores
    );

    final double minBiasScore = findMin(
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
      minBiasScore: minBiasScore,
    );
    notifyListeners();
  }

  void fetchWholeBiasScore() async {
    _state = state.copyWith(isWholeBiasScoreLoading: true);
    notifyListeners();
    _trackUserActivityUseCase.postUserWatchedArticles();
    final result = await _fetchWholeBiasScoreUseCase.fetchWholeBiasScore();

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
    switch(nickNameResult) {
      case ResultSuccess<bool, NickNameError> success:
        _state = state.copyWith(
          isEditMode: false,
          isBiasLoading: false,
        );
        final UserProfile result = await _manageUserProfileUseCase.fetchUserProfile();
        _state = state.copyWith(
          userProfile: result,
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
      _state.nicknameController.text = state.userProfile?.nickname ?? '';
    }
    _state = state.copyWith(isEditMode: !state.isEditMode);
    notifyListeners();
  }

  void setIsGuestLogin(){
    _state = state.copyWith(isGuestLogin: false);
    notifyListeners();
  }

  void checkIsGuestLogin() {
    _state = state.copyWith(isGuestLogin: _firebaseLoginUseCase.isGuest());
    notifyListeners();
  }

  void _fetchUserProfile() async{
    _state = state.copyWith(isBiasLoading: true);
    notifyListeners();
    final result = await _manageUserProfileUseCase.fetchUserProfile();

    _state = state.copyWith(
      userProfile: result,
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

  @override
  void dispose() {
    _profileStreamSubscription?.cancel();
    _eventController.close();
    super.dispose();
  }
}