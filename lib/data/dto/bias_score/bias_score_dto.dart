import 'package:could_be/domain/entities/bias_score/bias_score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_score_dto.g.dart';

@JsonSerializable()
class BiasScoreDto {
  final double left;
  final double center;
  final double right;

  BiasScoreDto(
    this.left,
    this.center,
    this.right,
  );

  factory BiasScoreDto.fromJson(Map<String, dynamic> json) =>
      _$BiasScoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasScoreDtoToJson(this);
}

extension BiasScoreDtx on BiasScoreDto {
  BiasScore toDomain() {
    return BiasScore(
      left: left,
      center: center,
      right: right,
    );
  }
}


