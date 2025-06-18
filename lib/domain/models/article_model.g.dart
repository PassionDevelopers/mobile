// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  id: json['_id'] as String,
  preview: json['preview'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String,
  content: json['content'] as String,
  url: json['url'] as String,
  reporter: json['reporter'] as String?,
  source: SourceModel.fromJson(json['source'] as Map<String, dynamic>),
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  issueId: json['issueId'] as String,
  category: json['category'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'preview': instance.preview,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'url': instance.url,
      'reporter': instance.reporter,
      'source': instance.source,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'issueId': instance.issueId,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
