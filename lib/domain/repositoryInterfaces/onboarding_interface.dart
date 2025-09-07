import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_result_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_vo.dart';

abstract class OnboardingRepository {
  Future<List<BiasQuizVo>> fetchBiasQuizList();

  Future<BiasQuizResultVo> submitBiasQuizAnswers(List<BiasQuizAnswerVo> answers);

  void submitSelectedBias(Bias bias);
}