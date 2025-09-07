import 'package:could_be/domain/entities/bias_quiz_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bias_quiz_dto.g.dart';

@JsonSerializable()
class BiasQuizDto {
  final int id;
  final String text;
  final String category;
  final String spectrum;

  BiasQuizDto(this.id, this.text, this.category, this.spectrum);

  factory BiasQuizDto.fromJson(Map<String, dynamic> json) =>
      _$BiasQuizDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiasQuizDtoToJson(this);
}

extension BiasQuizDtx on BiasQuizDto {
  BiasQuizVo toDomain() {
    return BiasQuizVo(
      id: id,
      text: text,
      category: category,
      spectrum: spectrum,
    );
  }
}
