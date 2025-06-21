// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDTO _$ArticleDTOFromJson(Map<String, dynamic> json) => ArticleDTO(
  id: json['_id'] as String,
  title: json['title'] as String,
  preview: json['preview'] as String,
  url: json['url'] as String,
  reporter: json['reporter'] as String?,
  publishedAt: json['publishedAt'] as String,
  issueId: json['issueId'] as String,
  category: json['category'] as String,
  imageUrl: json['imageUrl'] as String?,
  source: ArticleSourceDTO.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleDTOToJson(ArticleDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'preview': instance.preview,
      'url': instance.url,
      'reporter': instance.reporter,
      'publishedAt': instance.publishedAt,
      'issueId': instance.issueId,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'source': instance.source,
    };
