import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_quiz_result_vo.dart';

class BiasTestResultState {
  final BiasQuizResultVo? quizResultVo;
  final bool isLoading;
  final Bias currentBias;

  BiasTestResultState({
    this.quizResultVo,
    this.isLoading = false,
    this.currentBias = Bias.center,
  });

  BiasTestResultState copyWith({
    BiasQuizResultVo? quizResultVo,
    bool? isLoading,
    Bias? currentBias,
  }) {
    return BiasTestResultState(
      quizResultVo: quizResultVo ?? this.quizResultVo,
      isLoading: isLoading ?? this.isLoading,
      currentBias: currentBias ?? this.currentBias,
    );
  }
}