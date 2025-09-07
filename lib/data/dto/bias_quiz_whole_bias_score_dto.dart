import 'package:could_be/data/dto/bias_score_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_quiz_whole_bias_score_dto.g.dart';

@JsonSerializable()
class BiasQuizWholeBiasScoreDto {
  final BiasScoreDto politics;
  final BiasScoreDto economy;
  final BiasScoreDto society;
  final BiasScoreDto culture;
  final BiasScoreDto technology;
  final BiasScoreDto international;

  BiasQuizWholeBiasScoreDto(
    this.politics,
    this.economy,
    this.society,
    this.culture,
    this.technology,
    this.international,
  );

  factory BiasQuizWholeBiasScoreDto.fromJson(Map<String, dynamic> json) =>
      _$BiasQuizWholeBiasScoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasQuizWholeBiasScoreDtoToJson(this);
}
