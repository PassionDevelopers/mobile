

import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/user_bias.dart';

class MyPageState{
  final UserBias? userBias;
  final DasiScore? dasiScore;

  final bool isBiasLoading;
  final bool isDasiScoreLoading;
  final bool isUserStatusLoading;
  final bool isBiasScoreHistoryLoading;
  final bool isWholeBiasScoreLoading;

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
    this.userBias,
    this.dasiScore,
    this.isBiasLoading = false,
    this.isUserStatusLoading = false,
    this.isDasiScoreLoading = false,
    this.maxBiasScore = 100.0,

    required this.isGuestLogin,
    this.wholeBiasScore,
    this.isEditMode = false,
    this.biasNow = Bias.center,
    this.biasScorePeriod = BiasScorePeriod.monthly,
    this.biasScoreHistory,
    this.biasScoreHistoryLeftScores,
    this.biasScoreHistoryRightScores,
    this.biasScoreHistoryCenterScores,
    this.isBiasScoreHistoryLoading = false,
    this.isWholeBiasScoreLoading = false,
  });

  MyPageState copyWith({
    UserBias? userBias,
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
  }) {
    return MyPageState(
      userBias: userBias ?? this.userBias,
      dasiScore: dasiScore ?? this.dasiScore,
      isBiasLoading: isBiasLoading ?? this.isBiasLoading,
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