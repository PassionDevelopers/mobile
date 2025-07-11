
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final FetchUserBiasUseCase _fetchUserBiasUseCase;
  final ManageUserStatusUseCase _manageUserStatusUseCase;
  final FirebaseLoginUseCase _firebaseLoginUseCase;

  MyPageState _state = MyPageState(isGuestLogin: true);
  MyPageState get state => _state;

  MyPageViewModel({
    required FetchUserBiasUseCase fetchUserBiasUseCase,
    required ManageUserStatusUseCase manageUserStatusUseCase,
    required FirebaseLoginUseCase firebaseLoginUseCase,
  }) : _fetchUserBiasUseCase = fetchUserBiasUseCase,
      _firebaseLoginUseCase = firebaseLoginUseCase,
       _manageUserStatusUseCase = manageUserStatusUseCase {
    _fetchUserBias();
    _checkIsGuestLogin();
  }

  void _checkIsGuestLogin() {
    _state = state.copyWith(isGuestLogin: _firebaseLoginUseCase.isGuest());
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
    notifyListeners();
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