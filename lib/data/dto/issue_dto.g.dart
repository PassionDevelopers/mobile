// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDTO _$IssueDTOFromJson(Map<String, dynamic> json) => IssueDTO(
  id: json['_id'] as String,
  tags:
      (json['tags'] as List<dynamic>)
          .map((e) => IssueTagDto.fromJson(e as Map<String, dynamic>))
          .toList(),
  summary: json['summary'] as String,
  title: json['title'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  category: json['category'] as String,
  keywords:
      (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
  isSubscribed: json['isSubscribed'] as bool,
  imageUrl: json['imageUrl'] as String?,
  view: (json['view'] as num).toInt(),
  coverageSpectrum: CoverageSpectrumDTO.fromJson(
    json['coverageSpectrum'] as Map<String, dynamic>,
  ),
  leftLikeCount: (json['leftLikeCount'] as num).toInt(),
  centerLikeCount: (json['centerLikeCount'] as num).toInt(),
  rightLikeCount: (json['rightLikeCount'] as num).toInt(),
  userEvaluatedPerspective: json['userEvaluatedPerspective'] as String?,
);

Map<String, dynamic> _$IssueDTOToJson(IssueDTO instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'summary': instance.summary,
  'tags': instance.tags,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'leftLikeCount': instance.leftLikeCount,
  'centerLikeCount': instance.centerLikeCount,
  'rightLikeCount': instance.rightLikeCount,
  'keywords': instance.keywords,
  'imageUrl': instance.imageUrl,
  'view': instance.view,
  'isSubscribed': instance.isSubscribed,
  'coverageSpectrum': instance.coverageSpectrum,
  'userEvaluatedPerspective': instance.userEvaluatedPerspective,
};
