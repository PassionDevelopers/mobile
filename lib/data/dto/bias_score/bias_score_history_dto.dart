import 'package:could_be/data/dto/bias_score/bias_score_element_dto.dart';
import 'package:could_be/domain/entities/bias_score/bias_score_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_score_history_dto.g.dart';

@JsonSerializable()
class BiasScoreHistoryDto {
  final List<BiasScoreElementDto> history;

  BiasScoreHistoryDto(
    this.history,
  );

  factory BiasScoreHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$BiasScoreHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasScoreHistoryDtoToJson(this);
}

extension BiasScoreHistoryDtx on BiasScoreHistoryDto {
  BiasScoreHistory toDomain() {
    return BiasScoreHistory(
      history: history.map((e) => e.toDomain()).toList(),
    );
  }
}
