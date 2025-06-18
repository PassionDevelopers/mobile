// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDTO _$IssueDTOFromJson(Map<String, dynamic> json) => IssueDTO(
  id: json['_id'] as String,
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
  imageUrl: json['imageUrl'] as String?,
  view: (json['view'] as num).toInt(),
  coverageSpectrum: CoverageSpectrumModel.fromJson(
    json['coverageSpectrum'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$IssueDTOToJson(IssueDTO instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'summary': instance.summary,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'keywords': instance.keywords,
  'imageUrl': instance.imageUrl,
  'view': instance.view,
  'coverageSpectrum': instance.coverageSpectrum,
};
