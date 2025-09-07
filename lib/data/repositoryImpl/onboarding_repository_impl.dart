import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/data/dto/bias_quiz_dto.dart';
import 'package:could_be/data/dto/bias_quiz_result_dto.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_result_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_vo.dart';
import 'package:could_be/domain/repositoryInterfaces/onboarding_interface.dart';
import 'package:dio/dio.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final Dio dio;
  OnboardingRepositoryImpl(this.dio);

  @override
  Future<List<BiasQuizVo>> fetchBiasQuizList() async {
    final reponse = await dio.get('/user/exam/questions');
    final List<dynamic> data = reponse.data['questions'];
    final List<BiasQuizDto> dtoList = data.map((e) => BiasQuizDto.fromJson(e)).toList();
    return dtoList.map((e) => e.toDomain()).toList();
  }

  @override
  Future<BiasQuizResultVo> submitBiasQuizAnswers(List<BiasQuizAnswerVo> answers) async {
    final List<dynamic> answerList = answers.map((e) => e.toJson()).toList();
    final response = await dio.post(
      '/user/exam/analyze',
      data: {
        'answers': answerList,
      },
    );
    final resultDto = BiasQuizResultDto.fromJson(response.data);
    return resultDto.toDomain();
  }

  @override
  void submitSelectedBias(Bias bias) async{
    final response = await dio.post(
      '/user/onboarding',
      data: {
        'perspective': bias.toPerspective(),
      },
    );
  }

}