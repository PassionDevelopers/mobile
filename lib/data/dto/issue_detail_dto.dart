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

  IssueDetailDTO(
    this.id,
    this.title,
    this.category,
    this.summary,
    this.imageUrl,
    this.keywords,
    this.createdAt,
    this.view,
    this.coverageSpectrum,
    this.updatedAt,
    this.leftSummary,
    this.centerSummary,
    this.rightSummary,
    this.biasComparison,
    this.leftKeywords,
    this.centerKeywords,
    this.rightKeywords,
  );

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
    );
  }
}


