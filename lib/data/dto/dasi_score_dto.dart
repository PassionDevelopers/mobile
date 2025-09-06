import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dasi_score_dto.g.dart';

@JsonSerializable()
class DasiScoreDto {
  final double score;
  final DateTime? createdAt;
  final String userId;

  DasiScoreDto(this.score, this.createdAt, this.userId);

  factory DasiScoreDto.fromJson(Map<String, dynamic> json) =>
      _$DasiScoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DasiScoreDtoToJson(this);
}

extension DasiScoreDtx on DasiScoreDto {
  DasiScore toDomain() {
    return DasiScore(
      score: score,
      createdAt: createdAt,
      userId: userId,
    );
  }
}
