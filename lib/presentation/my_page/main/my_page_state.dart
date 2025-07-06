

import '../../../domain/entities/user_bias.dart';

class MyPageState{
  final UserBias? userBias;
  final bool isBiasLoading;
  final bool isUserStatusLoading;


  MyPageState({
    this.userBias,
    this.isBiasLoading = false,
    this.isUserStatusLoading = false,
  });

  MyPageState copyWith({
    UserBias? userBias,
    bool? isBiasLoading,
    bool? isUserStatusLoading,
  }) {
    return MyPageState(
      userBias: userBias ?? this.userBias,
      isBiasLoading: isBiasLoading ?? this.isBiasLoading,
      isUserStatusLoading: isUserStatusLoading ?? this.isUserStatusLoading,
    );
  }
}