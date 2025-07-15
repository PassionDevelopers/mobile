import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/articles.dart';
import 'article_dto.dart';
part 'articles_dto.g.dart';

@JsonSerializable()
class ArticlesDTO {
  final List<ArticleDTO> articles;
  final bool hasMore;
  final String? lastArticleId;

  ArticlesDTO({
    required this.articles,
    required this.hasMore,
    this.lastArticleId,
  });

  factory ArticlesDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticlesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesDTOToJson(this);
}

extension ArticlesDtx on ArticlesDTO {
  // Converts the DTO to a domain entity
  Articles toDomain() {
    return Articles(
      articles: articles.map((article) => article.toDomain()).toList(),
      hasMore: hasMore,
      lastArticleId: lastArticleId,
    );
  }
}
