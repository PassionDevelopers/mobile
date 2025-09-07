import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_result_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_vo.dart';
import 'package:could_be/domain/repositoryInterfaces/onboarding_interface.dart';

class OnboardingUseCase{
  final OnboardingRepository _onboardingRepository;
  OnboardingUseCase(this._onboardingRepository);

  Future<List<BiasQuizVo>> fetchBiasQuizList() async {
    return await _onboardingRepository.fetchBiasQuizList();
  }

  Future<BiasQuizResultVo> submitBiasQuizAnswers(List<BiasQuizAnswerVo> answers) async {
    return await _onboardingRepository.submitBiasQuizAnswers(answers);
  }

  void submitSelectedBias(bias) {
    _onboardingRepository.submitSelectedBias(bias);
  }

}