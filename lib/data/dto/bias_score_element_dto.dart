import 'package:could_be/data/dto/period_info_dto.dart';
import 'package:could_be/data/dto/whole_bias_score_only_dto.dart';
import 'package:could_be/domain/entities/bias_score_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_score_element_dto.g.dart';

@JsonSerializable()
class BiasScoreElementDto {
  final PeriodInfoDto period;
  final WholeBiasScoreOnlyDto? score;

  BiasScoreElementDto({
    required this.period,
    this.score,
});

  factory BiasScoreElementDto.fromJson(Map<String, dynamic> json) =>
      _$BiasScoreElementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasScoreElementDtoToJson(this);
}

extension BiasScoreElementDtx on BiasScoreElementDto {
  BiasScoreElement toDomain() {
    return BiasScoreElement(
      period: period.toDomain(),
      score: score?.toDomain(),
    );
  }
}

