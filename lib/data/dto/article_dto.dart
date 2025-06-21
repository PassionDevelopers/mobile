import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/article.dart';
import 'article_source_dto.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class ArticleDTO {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String preview;
  final String url;
  final String? reporter;
  final String publishedAt;
  final String issueId;
  final String category;
  final String? imageUrl;
  final ArticleSourceDTO source;

  ArticleDTO({
    required this.id,
    required this.title,
    required this.preview,
    required this.url,
    this.reporter,
    required this.publishedAt,
    required this.issueId,
    required this.category,
    this.imageUrl,
    required this.source,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDTOToJson(this);
}

extension ArticleDtx on ArticleDTO {
  // Converts the DTO to a domain entity
  Article toDomain() {
    return Article(
      id: id,
      title: title,
      preview: preview,
      url: url,
      reporter: reporter,
      publishedAt: publishedAt,
      issueId: issueId,
      category: category,
      imageUrl: imageUrl,
      source: source.toDomain(),
    );
  }
}