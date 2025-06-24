
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_state.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {

  final FetchUserBiasUseCase _fetchUserBiasUseCase;

  MyPageState _state = MyPageState();
  MyPageState get state => _state;

  MyPageViewModel({
    required FetchUserBiasUseCase fetchUserBiasUseCase,
  }) : _fetchUserBiasUseCase = fetchUserBiasUseCase {
    _fetchUserBias();
  }

  void _fetchUserBias() async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchUserBiasUseCase.execute();

    _state = state.copyWith(
      userBias: getBiasName(result.bias),
      isLoading: false,
    );
    notifyListeners();
  }
}