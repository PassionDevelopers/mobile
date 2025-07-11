

import '../../../domain/entities/user_bias.dart';

class MyPageState{
  final UserBias? userBias;
  final bool isBiasLoading;
  final bool isUserStatusLoading;
  final bool isGuestLogin;


  MyPageState({
    this.userBias,
    this.isBiasLoading = false,
    this.isUserStatusLoading = false,
    required this.isGuestLogin,
  });

  MyPageState copyWith({
    UserBias? userBias,
    bool? isBiasLoading,
    bool? isUserStatusLoading,
    bool? isGuestLogin,
  }) {
    return MyPageState(
      userBias: userBias ?? this.userBias,
      isBiasLoading: isBiasLoading ?? this.isBiasLoading,
      isUserStatusLoading: isUserStatusLoading ?? this.isUserStatusLoading,
      isGuestLogin: isGuestLogin ?? this.isGuestLogin,
    );
  }
}