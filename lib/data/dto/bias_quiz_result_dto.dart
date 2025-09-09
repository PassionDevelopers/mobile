import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/data/dto/bias_quiz_whole_bias_score_dto.dart';
import 'package:could_be/data/dto/bias_score/bias_score_dto.dart';
import 'package:could_be/data/dto/bias_score/whole_bias_score_dto.dart';
import 'package:could_be/domain/entities/bias_quiz_result_vo.dart';
import 'package:could_be/domain/entities/bias_score/whole_bias_score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_quiz_result_dto.g.dart';

@JsonSerializable()
class BiasQuizResultDto {
  final String perspective;
  final String summary;
  final String dominantCategory;
  final BiasQuizWholeBiasScoreDto scores;

  BiasQuizResultDto(
    this.perspective,
    this.summary,
    this.dominantCategory,
    this.scores,
  );

  factory BiasQuizResultDto.fromJson(Map<String, dynamic> json) =>
      _$BiasQuizResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasQuizResultDtoToJson(this);
}

extension BiasQuizResultDtx on BiasQuizResultDto {
  BiasQuizResultVo toDomain() {
    return BiasQuizResultVo(
      bias: getBiasFromString(perspective),
      summary: summary,
      dominantCategory: dominantCategory,
      wholeBiasScore: WholeBiasScore(
        politics: scores.politics.toDomain(),
        economy: scores.economy.toDomain(),
        society: scores.society.toDomain(),
        culture: scores.culture.toDomain(),
        technology: scores.technology.toDomain(),
        international: scores.international.toDomain(),
        createdAt: DateTime.now(),
        userId: '',
      ),
    );
  }
}



