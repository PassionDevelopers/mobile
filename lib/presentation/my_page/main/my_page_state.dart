

import 'package:flutter/material.dart';

import '../../../domain/entities/user_bias.dart';

class MyPageState{
  final UserBias? userBias;
  final bool isBiasLoading;
  final bool isUserStatusLoading;
  final bool isGuestLogin;
  final bool isEditMode;
  final TextEditingController nicknameController = TextEditingController();


  MyPageState({
    this.userBias,
    this.isBiasLoading = false,
    this.isUserStatusLoading = false,
    required this.isGuestLogin,
    this.isEditMode = false,
  });

  MyPageState copyWith({
    UserBias? userBias,
    bool? isBiasLoading,
    bool? isUserStatusLoading,
    bool? isGuestLogin,
    bool? isEditMode,
  }) {
    return MyPageState(
      userBias: userBias ?? this.userBias,
      isBiasLoading: isBiasLoading ?? this.isBiasLoading,
      isUserStatusLoading: isUserStatusLoading ?? this.isUserStatusLoading,
      isGuestLogin: isGuestLogin ?? this.isGuestLogin,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}