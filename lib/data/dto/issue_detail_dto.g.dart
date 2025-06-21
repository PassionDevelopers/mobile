// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDetailDTO _$IssueDetailDTOFromJson(Map<String, dynamic> json) =>
    IssueDetailDTO(
      json['_id'] as String,
      json['title'] as String,
      json['category'] as String,
      json['summary'] as String,
      json['imageUrl'] as String,
      (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      json['createdAt'] as String,
      (json['view'] as num).toInt(),
      CoverageSpectrumDTO.fromJson(
        json['coverageSpectrum'] as Map<String, dynamic>,
      ),
      json['updatedAt'] as String,
      json['leftSummary'] as String,
      json['centerSummary'] as String,
      json['rightSummary'] as String,
      json['biasComparison'] as String,
      (json['leftKeywords'] as List<dynamic>).map((e) => e as String).toList(),
      (json['centerKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['rightKeywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IssueDetailDTOToJson(IssueDetailDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
      'keywords': instance.keywords,
      'createdAt': instance.createdAt,
      'view': instance.view,
      'coverageSpectrum': instance.coverageSpectrum,
      'updatedAt': instance.updatedAt,
      'leftSummary': instance.leftSummary,
      'centerSummary': instance.centerSummary,
      'rightSummary': instance.rightSummary,
      'biasComparison': instance.biasComparison,
      'leftKeywords': instance.leftKeywords,
      'centerKeywords': instance.centerKeywords,
      'rightKeywords': instance.rightKeywords,
    };
