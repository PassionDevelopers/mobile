import 'dart:developer';

import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/useCases/onboarding_use_case.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_state.dart';
import 'package:flutter/material.dart';

class BiasTestViewModel with ChangeNotifier {

  final OnboardingUseCase _onboardingUseCase;
  BiasTestViewModel({
    required OnboardingUseCase onboardingUseCase,
  }) : _onboardingUseCase = onboardingUseCase {
    fetchBiasQuizList();
}

  BiasTestState _state = BiasTestState();
  BiasTestState get state => _state;

  final PageController pageController = PageController();

  void fetchBiasQuizList() async {
    _state = state.copyWith(
      isLoadingQuiz: true,
    );
    notifyListeners();

    try {
      final quizList = await _onboardingUseCase.fetchBiasQuizList();
      _state = state.copyWith(
        quizList: quizList,
        answerList: quizList.map((e) => BiasQuizAnswerVo(questionId: e.id, value: null)).toList(),
      );
    } catch (e) {
      log('Error fetching bias quiz list: $e');
    } finally {
      _state = state.copyWith(
        isLoadingQuiz: false,
      );
      notifyListeners();
    }
  }

  void submitAnswers() {
    if(state.answerList == null || state.answerList!.any((answer) => answer.value == null)) {
      showMyToast(msg: '모든 문항에 답변해주세요.');
      return;
    }
    router.go(RouteNames.biasTestResult, extra: state.answerList);
  }

  void onPageChanged(int index) {
    _state = state.copyWith(
      currentPageIndex: index,
    );
    notifyListeners();
  }

  void selectAnswer({required int quizId, required int value}) {
    _state = state.copyWith(
      answerList: state.answerList!.map((e) => e.questionId == quizId ?
        BiasQuizAnswerVo(questionId: quizId, value: value) : e).toList(),
    );
    notifyListeners();
  }
}