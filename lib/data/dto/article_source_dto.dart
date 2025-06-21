import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/article_source.dart';

part 'article_source_dto.g.dart';

@JsonSerializable()
class ArticleSourceDTO {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String perspective;

  ArticleSourceDTO({
    required this.id,
    required this.name,
    required this.perspective,
  });

  factory ArticleSourceDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleSourceDTOToJson(this);
}

extension ArticleSourceDtx on ArticleSourceDTO {
  // Converts the DTO to a domain entity
  ArticleSource toDomain() {
    return ArticleSource(
      id: id,
      name: name,
      perspective: perspective,
    );
  }
}
