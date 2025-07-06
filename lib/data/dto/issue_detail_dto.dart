import 'package:could_be/data/dto/articles_dto.dart';
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
  final String? imageUrl;
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
  final String? biasComparison;
  final List<String>? leftKeywords;
  final List<String>? centerKeywords;
  final List<String>? rightKeywords;
  final List<String> nextIssueIds;
  final bool isSubscribed;
  final ArticlesDTO articles;

  IssueDetailDTO({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    this.imageUrl,
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
    this.biasComparison,
    this.leftKeywords,
     this.centerKeywords,
     this.rightKeywords,
    required this.nextIssueIds,
    required this.isSubscribed,
    required this.articles,
  });

  factory IssueDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$IssueDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDetailDTOToJson(this);
}

extension IssueDetailDtx on IssueDetailDTO {
  // Converts the DTO to a domain entity
  IssueDetail toDomain() {
    return IssueDetail(
      leftLikeCount: leftLikeCount,
      centerLikeCount: centerLikeCount,
      rightLikeCount: rightLikeCount,
      id: id,
      title: title,
      category: category,
      summary: summary,
      imageUrl: imageUrl,
      keywords: keywords,
      createdAt: DateTime.parse(createdAt),
      view: view,
      coverageSpectrum: coverageSpectrum.toDomain(),
      updatedAt: updatedAt != null? DateTime.parse(updatedAt!) : null,
      leftSummary: leftSummary != null && leftSummary!.isEmpty ? null : leftSummary,
      centerSummary: centerSummary != null && centerSummary!.isEmpty ? null : centerSummary,
      rightSummary: rightSummary != null && rightSummary!.isEmpty ? null : rightSummary,
      biasComparison: biasComparison != null && biasComparison!.isEmpty ? null : biasComparison,
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


