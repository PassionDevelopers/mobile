import 'dart:developer';

import 'package:could_be/data/dto/articles_dto.dart';
import 'package:could_be/data/dto/issue_tag_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/issue_detail.dart';
import 'coverage_spectrum_dto.dart';

part 'issue_detail_dto.g.dart';

@JsonSerializable()
class IssueDetailDTO {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String category;
  final String summary;
  final List<IssueTagDto> tags;
  final String? commonSummary;
  final String? imageUrl;
  final String? imageSource;
  final List<String> keywords;
  final String createdAt;
  final int view;
  final CoverageSpectrumDTO coverageSpectrum;
  final String? updatedAt;
  final String? userEvaluation;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final String? leftSummary;
  final String? centerSummary;
  final String? rightSummary;

  final int commentsCount;

  final String? leftComparison;
  final String? centerComparison;
  final String? rightComparison;
  final List<String>? leftKeywords;
  final List<String>? centerKeywords;
  final List<String>? rightKeywords;
  final List<String> nextIssueIds;
  final bool isSubscribed;
  final ArticlesDTO articles;

  IssueDetailDTO({
    required this.tags,
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    this.commonSummary,
    this.imageUrl,
    this.imageSource,
    required this.keywords,
    required this.createdAt,
    required this.view,
    required this.coverageSpectrum,
    this.updatedAt,
    this.userEvaluation,
    this.leftSummary,
    this.centerSummary,
    this.rightSummary,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.commentsCount,
    this.leftComparison,
    this.centerComparison,
    this.rightComparison,
    this.leftKeywords,
     this.centerKeywords,
     this.rightKeywords,
    required this.nextIssueIds,
    required this.isSubscribed,
    required this.articles,
  });

  factory IssueDetailDTO.fromJson(Map<String, dynamic> json){
    log('Creating IssueDetailDTO from JSON: $json');
    return _$IssueDetailDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IssueDetailDTOToJson(this);
}

extension IssueDetailDtx on IssueDetailDTO {
  // Converts the DTO to a domain entity
  IssueDetail toDomain() {
    return IssueDetail(
      tags: tags.map((tag) => tag.toDomain()).toList(),
      leftLikeCount: leftLikeCount,
      centerLikeCount: centerLikeCount,
      rightLikeCount: rightLikeCount,
      id: id,
      title: title,
      category: category,
      summary: summary,
      commonSummary: commonSummary,
      imageUrl: imageUrl,
      imageSource: imageSource,
      keywords: keywords,
      createdAt: DateTime.parse(createdAt),
      view: view,
      commentsCount: commentsCount,
      coverageSpectrum: coverageSpectrum.toDomain(),
      updatedAt: updatedAt != null? DateTime.parse(updatedAt!) : null,
      leftSummary: leftSummary != null && leftSummary!.isEmpty ? null : leftSummary,
      centerSummary: centerSummary != null && centerSummary!.isEmpty ? null : centerSummary,
      rightSummary: rightSummary != null && rightSummary!.isEmpty ? null : rightSummary,
      leftComparison: leftComparison != null && leftComparison!.isEmpty ? null : leftComparison,
      centerComparison: centerComparison != null && centerComparison!.isEmpty ? null : centerComparison,
      rightComparison: rightComparison != null && rightComparison!.isEmpty ? null : rightComparison,
      leftKeywords: leftKeywords != null && leftKeywords!.isEmpty ? null : leftKeywords,
      centerKeywords: centerKeywords != null && centerKeywords!.isEmpty ? null : centerKeywords,
      rightKeywords: rightKeywords != null && rightKeywords!.isEmpty ? null : rightKeywords,
      nextIssueIds: nextIssueIds,
      isSubscribed: isSubscribed,
      articles: articles.toDomain(),
      userEvaluation: userEvaluation,
    );
  }
}


