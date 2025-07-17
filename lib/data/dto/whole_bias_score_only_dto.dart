import 'package:could_be/data/dto/bias_score_dto.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/entities/whole_bias_score_only.dart';
import 'package:json_annotation/json_annotation.dart';
part 'whole_bias_score_only_dto.g.dart';

@JsonSerializable()
class WholeBiasScoreOnlyDto {
  final BiasScoreDto politics;
  final BiasScoreDto economy;
  final BiasScoreDto society;
  final BiasScoreDto culture;
  final BiasScoreDto technology;
  final BiasScoreDto international;

  WholeBiasScoreOnlyDto(
      this.politics,
      this.economy,
      this.society,
      this.culture,
      this.technology,
      this.international,
      );

  factory WholeBiasScoreOnlyDto.fromJson(Map<String, dynamic> json) =>
      _$WholeBiasScoreOnlyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WholeBiasScoreOnlyDtoToJson(this);
}

extension WholeBiasScoreDtx on WholeBiasScoreOnlyDto {
  WholeBiasScoreOnly toDomain() {
    return WholeBiasScoreOnly(
      politics: politics.toDomain(),
      economy: economy.toDomain(),
      society: society.toDomain(),
      culture: culture.toDomain(),
      technology: technology.toDomain(),
      international: international.toDomain(),
    );
  }
}

