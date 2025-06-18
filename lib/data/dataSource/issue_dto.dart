import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/issue.dart';
import '../../domain/models/coverage_spectrum_model.dart';
part 'issue_dto.g.dart';

@JsonSerializable()
class IssueDTO{
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String category;
  final String summary;

  final DateTime createdAt;
  final DateTime? updatedAt;


  final List<String> keywords;
  final String? imageUrl;
  final int view;
  final CoverageSpectrumModel coverageSpectrum;

  IssueDTO({
    required this.id,
    required this.summary,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    required this.keywords,
    this.imageUrl,
    required this.view,
    required this.coverageSpectrum,
  });

  factory IssueDTO.fromJson(Map<String, dynamic> json) => _$IssueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDTOToJson(this);
}

extension IssueDtoX on IssueDTO {
  Issue toDomain() {
    return Issue(
      id: id,
      title: title,
      category: category,
      summary: summary,
      createdAt: createdAt,
      updatedAt: updatedAt ?? createdAt,
      keywords: keywords,
      imageUrl: imageUrl,
      view: view,
      coverageSpectrum: coverageSpectrum,
    );
  }
}