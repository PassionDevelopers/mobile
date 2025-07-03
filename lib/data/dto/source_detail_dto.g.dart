// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceDetailDto _$SourceDetailDtoFromJson(Map<String, dynamic> json) =>
    SourceDetailDto(
      json['_id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['perspective'] as String,
      json['url'] as String,
      json['logoUrl'] as String,
      ArticlesDTO.fromJson(json['recentArticles'] as Map<String, dynamic>),
      json['isSubscribed'] as bool,
      json['userEvaluatedPerspective'] as String?,
      json['aiEvaluatedPerspective'] as String,
      json['expertEvaluatedPerspective'] as String?,
      (json['publicEvaluatedPerspective'] as num?)?.toInt(),
      (json['followersCount'] as num).toInt(),
      json['notificationEnabled'] as bool,
    );

Map<String, dynamic> _$SourceDetailDtoToJson(SourceDetailDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'perspective': instance.perspective,
      'url': instance.url,
      'logoUrl': instance.logoUrl,
      'recentArticles': instance.recentArticles,
      'isSubscribed': instance.isSubscribed,
      'userEvaluatedPerspective': instance.userEvaluatedPerspective,
      'aiEvaluatedPerspective': instance.aiEvaluatedPerspective,
      'expertEvaluatedPerspective': instance.expertEvaluatedPerspective,
      'publicEvaluatedPerspective': instance.publicEvaluatedPerspective,
      'followersCount': instance.followersCount,
      'notificationEnabled': instance.notificationEnabled,
    };
