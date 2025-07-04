
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final FetchUserBiasUseCase _fetchUserBiasUseCase;
  final ManageUserStatusUseCase _manageUserStatusUseCase;

  MyPageState _state = MyPageState();
  MyPageState get state => _state;

  MyPageViewModel({
    required FetchUserBiasUseCase fetchUserBiasUseCase,
    required ManageUserStatusUseCase manageUserStatusUseCase,
  }) : _fetchUserBiasUseCase = fetchUserBiasUseCase,
       _manageUserStatusUseCase = manageUserStatusUseCase {
    _fetchUserBias();
  }

  void _fetchUserBias() async{
    _state = state.copyWith(isBiasLoading: true);
    notifyListeners();
    final result = await _fetchUserBiasUseCase.execute();

    _state = state.copyWith(
      userBias: getBiasName(result.bias),
      isBiasLoading: false,
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    _state = state.copyWith(isUserStatusLoading: true);
    notifyListeners();
    await _manageUserStatusUseCase.signOutWithGoogle();
    _state = state.copyWith(isUserStatusLoading: false);
    notifyListeners();
  }
}