// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesDTO _$ArticlesDTOFromJson(Map<String, dynamic> json) => ArticlesDTO(
  articles:
      (json['articles'] as List<dynamic>)
          .map((e) => ArticleDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasMore: json['hasMore'] as bool,
  lastArticleId: json['lastArticleId'] as String,
);

Map<String, dynamic> _$ArticlesDTOToJson(ArticlesDTO instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'hasMore': instance.hasMore,
      'lastArticleId': instance.lastArticleId,
    };
