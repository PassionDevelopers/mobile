

import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:flutter/material.dart';

class MyPageState{
  final UserProfile? userProfile;
  final DasiScore? dasiScore;

  final bool isBiasLoading;
  final bool isDasiScoreLoading;
  final bool isUserStatusLoading;
  final bool isBiasScoreHistoryLoading;
  final bool isWholeBiasScoreLoading;

  final bool isHexagonAbsolute;

  final bool isGuestLogin;
  final bool isEditMode;
  final WholeBiasScore? wholeBiasScore;
  final BiasScoreHistory? biasScoreHistory;
  final double maxBiasScore;
  final List<double>? biasScoreHistoryLeftScores;
  final List<double>? biasScoreHistoryRightScores;
  final List<double>? biasScoreHistoryCenterScores;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nicknameController = TextEditingController();

  final Bias biasNow;
  final BiasScorePeriod biasScorePeriod;


  MyPageState({
    this.userProfile,
    this.dasiScore,
    this.isBiasLoading = false,
    this.isUserStatusLoading = false,
    this.isDasiScoreLoading = false,
    this.maxBiasScore = 100.0,
    this.isHexagonAbsolute = true,

    required this.isGuestLogin,
    this.wholeBiasScore,
    this.isEditMode = false,
    this.biasNow = Bias.center,
    this.biasScorePeriod = BiasScorePeriod.weekly,
    this.biasScoreHistory,
    this.biasScoreHistoryLeftScores,
    this.biasScoreHistoryRightScores,
    this.biasScoreHistoryCenterScores,
    this.isBiasScoreHistoryLoading = false,
    this.isWholeBiasScoreLoading = false,
  });

  MyPageState copyWith({
    UserProfile? userProfile,
    DasiScore? dasiScore,
    bool? isBiasLoading,
    bool? isDasiScoreLoading,
    bool? isBiasScoreHistoryLoading,
    bool? isWholeBiasScoreLoading,
    bool? isUserStatusLoading,
    bool? isGuestLogin,
    bool? isEditMode,
    WholeBiasScore? wholeBiasScore,
    Bias? biasNow,
    BiasScorePeriod? biasScorePeriod,
    BiasScoreHistory? biasScoreHistory,
    List<double>? biasScoreHistoryLeftScores,
    List<double>? biasScoreHistoryCenterScores,
    List<double>? biasScoreHistoryRightScores,
    double? maxBiasScore,
    bool? isHexagonAbsolute,
  }) {
    return MyPageState(
      userProfile: userProfile ?? this.userProfile,
      dasiScore: dasiScore ?? this.dasiScore,
      isBiasLoading: isBiasLoading ?? this.isBiasLoading,
      isHexagonAbsolute: isHexagonAbsolute ?? this.isHexagonAbsolute,
      isDasiScoreLoading: isDasiScoreLoading ?? this.isDasiScoreLoading,
      isBiasScoreHistoryLoading: isBiasScoreHistoryLoading ?? this.isBiasScoreHistoryLoading,
      isWholeBiasScoreLoading: isWholeBiasScoreLoading ?? this.isWholeBiasScoreLoading,
      isUserStatusLoading: isUserStatusLoading ?? this.isUserStatusLoading,
      isGuestLogin: isGuestLogin ?? this.isGuestLogin,
      isEditMode: isEditMode ?? this.isEditMode,
      wholeBiasScore: wholeBiasScore ?? this.wholeBiasScore,
      biasNow: biasNow ?? this.biasNow,
      biasScoreHistory: biasScoreHistory ?? this.biasScoreHistory,
      biasScoreHistoryLeftScores: biasScoreHistoryLeftScores ?? this.biasScoreHistoryLeftScores,
      biasScoreHistoryRightScores: biasScoreHistoryRightScores ?? this.biasScoreHistoryRightScores,
      biasScoreHistoryCenterScores: biasScoreHistoryCenterScores ?? this.biasScoreHistoryCenterScores,
      biasScorePeriod: biasScorePeriod ?? this.biasScorePeriod,
      maxBiasScore: maxBiasScore ?? this.maxBiasScore,
    );
  }
}