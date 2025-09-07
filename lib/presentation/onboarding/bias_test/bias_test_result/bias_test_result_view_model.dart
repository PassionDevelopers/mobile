import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/useCases/onboarding_use_case.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_result/bias_test_result_state.dart';
import 'package:flutter/cupertino.dart';

class BiasTestResultViewModel with ChangeNotifier{
  final OnboardingUseCase _onboardingUseCase;
  final List<BiasQuizAnswerVo> answers;


  BiasTestResultViewModel({
    required OnboardingUseCase onboardingUseCase,
    required this.answers,
  }) : _onboardingUseCase = onboardingUseCase{
    submitAnswers();
  }

  BiasTestResultState _state = BiasTestResultState();
  BiasTestResultState get state => _state;

  void submitAnswers() async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try {
      final result = await _onboardingUseCase.submitBiasQuizAnswers(answers);
      _state = state.copyWith(
        quizResultVo: result,
      );
    } catch (e) {
      // Handle error appropriately, e.g., log it or update state with error info
    } finally {
      _state = state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  void setCurrentBias(Bias bias) {
    _state = state.copyWith(currentBias: bias);
    notifyListeners();
  }
}