// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDetailDTO _$IssueDetailDTOFromJson(
  Map<String, dynamic> json,
) => IssueDetailDTO(
  id: json['_id'] as String,
  title: json['title'] as String,
  category: json['category'] as String,
  summary: json['summary'] as String,
  imageUrl: json['imageUrl'] as String?,
  keywords:
      (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: json['createdAt'] as String,
  view: (json['view'] as num).toInt(),
  coverageSpectrum: CoverageSpectrumDTO.fromJson(
    json['coverageSpectrum'] as Map<String, dynamic>,
  ),
  updatedAt: json['updatedAt'] as String?,
  leftSummary: json['leftSummary'] as String,
  centerSummary: json['centerSummary'] as String,
  rightSummary: json['rightSummary'] as String,
  biasComparison: json['biasComparison'] as String,
  leftKeywords:
      (json['leftKeywords'] as List<dynamic>).map((e) => e as String).toList(),
  centerKeywords:
      (json['centerKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  rightKeywords:
      (json['rightKeywords'] as List<dynamic>).map((e) => e as String).toList(),
  nextIssueIds:
      (json['nextIssueIds'] as List<dynamic>).map((e) => e as String).toList(),
  isSubscribed: json['isSubscribed'] as bool,
  articles: ArticlesDTO.fromJson(json['articles'] as Map<String, dynamic>),
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
      'nextIssueIds': instance.nextIssueIds,
      'isSubscribed': instance.isSubscribed,
      'articles': instance.articles,
    };
