

import '../../../domain/entities/user_bias.dart';

class MyPageState{
  final String? userBias;
  final bool isLoading;

  MyPageState({
    this.userBias,
    this.isLoading = false,
  });

  MyPageState copyWith({
    String? userBias,
    bool? isLoading,
  }) {
    return MyPageState(
      userBias: userBias ?? this.userBias,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}