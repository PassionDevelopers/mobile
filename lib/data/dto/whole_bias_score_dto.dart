import 'package:could_be/data/dto/bias_score_dto.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'whole_bias_score_dto.g.dart';

@JsonSerializable()
class WholeBiasScoreDto {
  final BiasScoreDto politics;
  final BiasScoreDto economy;
  final BiasScoreDto society;
  final BiasScoreDto culture;
  final BiasScoreDto technology;
  final BiasScoreDto international;
  final DateTime createdAt;
  final String userId;

  WholeBiasScoreDto({
    required this.politics,
    required this.economy,
    required this.society,
    required this.culture,
    required this.technology,
    required this.international,
    required this.createdAt,
    required this.userId,
  });

  factory WholeBiasScoreDto.fromJson(Map<String, dynamic> json) =>
      _$WholeBiasScoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WholeBiasScoreDtoToJson(this);
}

extension WholeBiasScoreDtx on WholeBiasScoreDto {
  WholeBiasScore toDomain() {
    return WholeBiasScore(
      politics: politics.toDomain(),
      economy: economy.toDomain(),
      society: society.toDomain(),
      culture: culture.toDomain(),
      technology: technology.toDomain(),
      international: international.toDomain(),
      createdAt: createdAt,
      userId: userId,
    );
  }
}

