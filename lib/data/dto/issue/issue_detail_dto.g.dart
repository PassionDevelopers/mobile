// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDetailDTO _$IssueDetailDTOFromJson(Map<String, dynamic> json) =>
    IssueDetailDTO(
      tags:
          (json['tags'] as List<dynamic>)
              .map((e) => IssueTagDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      id: json['_id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      summary: json['summary'] as String,
      commonSummary: json['commonSummary'] as String?,
      imageUrl: json['imageUrl'] as String?,
      imageSource: json['imageSource'] as String?,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String,
      view: (json['view'] as num).toInt(),
      coverageSpectrum: CoverageSpectrumDTO.fromJson(
        json['coverageSpectrum'] as Map<String, dynamic>,
      ),
      updatedAt: json['updatedAt'] as String?,
      userEvaluation: json['userEvaluation'] as String?,
      leftSummary: json['leftSummary'] as String?,
      centerSummary: json['centerSummary'] as String?,
      rightSummary: json['rightSummary'] as String?,
      leftLikeCount: (json['leftLikeCount'] as num).toInt(),
      centerLikeCount: (json['centerLikeCount'] as num).toInt(),
      rightLikeCount: (json['rightLikeCount'] as num).toInt(),
      commentsCount: (json['commentsCount'] as num).toInt(),
      leftComparison: json['leftComparison'] as String?,
      centerComparison: json['centerComparison'] as String?,
      rightComparison: json['rightComparison'] as String?,
      leftKeywords:
          (json['leftKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      centerKeywords:
          (json['centerKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      rightKeywords:
          (json['rightKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      nextIssueIds:
          (json['nextIssueIds'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      isSubscribed: json['isSubscribed'] as bool,
      articles: ArticlesDTO.fromJson(json['articles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IssueDetailDTOToJson(IssueDetailDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'summary': instance.summary,
      'tags': instance.tags,
      'commonSummary': instance.commonSummary,
      'imageUrl': instance.imageUrl,
      'imageSource': instance.imageSource,
      'keywords': instance.keywords,
      'createdAt': instance.createdAt,
      'view': instance.view,
      'coverageSpectrum': instance.coverageSpectrum,
      'updatedAt': instance.updatedAt,
      'userEvaluation': instance.userEvaluation,
      'leftLikeCount': instance.leftLikeCount,
      'centerLikeCount': instance.centerLikeCount,
      'rightLikeCount': instance.rightLikeCount,
      'leftSummary': instance.leftSummary,
      'centerSummary': instance.centerSummary,
      'rightSummary': instance.rightSummary,
      'commentsCount': instance.commentsCount,
      'leftComparison': instance.leftComparison,
      'centerComparison': instance.centerComparison,
      'rightComparison': instance.rightComparison,
      'leftKeywords': instance.leftKeywords,
      'centerKeywords': instance.centerKeywords,
      'rightKeywords': instance.rightKeywords,
      'nextIssueIds': instance.nextIssueIds,
      'isSubscribed': instance.isSubscribed,
      'articles': instance.articles,
    };
