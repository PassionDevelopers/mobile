import 'package:could_be/data/dto/source/source_dto.dart';
import 'package:could_be/domain/entities/source/sources.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sources_dto.g.dart';

@JsonSerializable()
class SourcesDTO {
  final List<SourceDTO> sources;

  SourcesDTO(this.sources);

  factory SourcesDTO.fromJson(Map<String, dynamic> json) =>
      _$SourcesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesDTOToJson(this);
}

extension SourcesDtx on SourcesDTO {
  Sources toDomain() {
    return Sources(
      sources: sources.map((source) => source.toDomain()).toList(),
    );
  }
}