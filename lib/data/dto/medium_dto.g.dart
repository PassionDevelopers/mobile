// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medium_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediumDTO _$MediumDTOFromJson(Map<String, dynamic> json) => MediumDTO(
  id: json['_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  perspective: json['perspective'] as String,
  url: json['url'] as String,
  logoUrl: json['logoUrl'] as String,
  recentIssues: IssuesDTO.fromJson(
    json['recentIssues'] as Map<String, dynamic>,
  ),
  recentArticles: ArticlesDTO.fromJson(
    json['recentArticles'] as Map<String, dynamic>,
  ),
  isSubscribed: json['isSubscribed'] as bool,
  userEvaluatedPerspective: json['userEvaluatedPerspective'] as String?,
);

Map<String, dynamic> _$MediumDTOToJson(MediumDTO instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'perspective': instance.perspective,
  'url': instance.url,
  'logoUrl': instance.logoUrl,
  'recentIssues': instance.recentIssues,
  'recentArticles': instance.recentArticles,
  'isSubscribed': instance.isSubscribed,
  'userEvaluatedPerspective': instance.userEvaluatedPerspective,
};
