// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_source_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSourceDTO _$ArticleSourceDTOFromJson(Map<String, dynamic> json) =>
    ArticleSourceDTO(
      id: json['_id'] as String,
      name: json['name'] as String,
      perspective: json['perspective'] as String,
    );

Map<String, dynamic> _$ArticleSourceDTOToJson(ArticleSourceDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'perspective': instance.perspective,
    };
