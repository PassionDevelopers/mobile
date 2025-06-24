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
  final String imageUrl;
  final List<String> keywords;
  final String createdAt;
  final int view;
  final CoverageSpectrumDTO coverageSpectrum;
  final String updatedAt;
  final String leftSummary;
  final String centerSummary;
  final String rightSummary;
  final String biasComparison;
  final List<String> leftKeywords;
  final List<String> centerKeywords;
  final List<String> rightKeywords;
  final List<String> nextIssueIds;
  final bool isSubscribed;

  IssueDetailDTO({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.imageUrl,
    required this.keywords,
    required this.createdAt,
    required this.view,
    required this.coverageSpectrum,
    required this.updatedAt,
    required this.leftSummary,
    required this.centerSummary,
    required this.rightSummary,
    required this.biasComparison,
    required this.leftKeywords,
    required this.centerKeywords,
    required this.rightKeywords,
    required this.nextIssueIds,
    required this.isSubscribed
  });

  factory IssueDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$IssueDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDetailDTOToJson(this);
}

extension IssueDetailDtx on IssueDetailDTO {
  // Converts the DTO to a domain entity
  IssueDetail toDomain() {
    return IssueDetail(
      id: id,
      title: title,
      category: category,
      summary: summary,
      imageUrl: imageUrl,
      keywords: keywords,
      createdAt: DateTime.parse(createdAt),
      view: view,
      coverageSpectrum: coverageSpectrum.toDomain(),
      updatedAt: DateTime.parse(updatedAt),
      leftSummary: leftSummary,
      centerSummary: centerSummary,
      rightSummary: rightSummary,
      biasComparison: biasComparison,
      leftKeywords: leftKeywords,
      centerKeywords: centerKeywords,
      rightKeywords: rightKeywords,
      nextIssueIds: nextIssueIds,
      isSubscribed: isSubscribed,
    );
  }
}


