import 'package:could_be/data/dto/issue_tag_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/issue.dart';
import 'coverage_spectrum_dto.dart';
part 'issue_dto.g.dart';

@JsonSerializable()
class IssueDTO{
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String category;
  final String summary;

  final List<IssueTagDto> tags;

  final bool? isRead;

  final DateTime createdAt;
  final DateTime? updatedAt;

  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;

  final List<String> keywords;
  final String? imageUrl;
  final int view;
  final bool isSubscribed;
  final CoverageSpectrumDTO coverageSpectrum;

  final String? userEvaluatedPerspective;

  IssueDTO({
    required this.id,
    required this.tags,
    required this.summary,
    this.isRead,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    required this.keywords,
    required this.isSubscribed,
    this.imageUrl,
    required this.view,

    required this.coverageSpectrum,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    this.userEvaluatedPerspective
  });

  factory IssueDTO.fromJson(Map<String, dynamic> json) => _$IssueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDTOToJson(this);
}

extension IssueDtoX on IssueDTO {
  Issue toDomain() {
    return Issue(
      tags: tags.map((tag) => tag.toDomain()).toList(),
      userEvaluatedPerspective: userEvaluatedPerspective,
      leftLikeCount: leftLikeCount,
      centerLikeCount: centerLikeCount,
      rightLikeCount: rightLikeCount,
      id: id,
      isRead: isRead ?? false,
      title: title,
      category: category,
      summary: summary,
      createdAt: createdAt,
      updatedAt: updatedAt ?? createdAt,
      keywords: keywords,
      imageUrl: imageUrl,
      view: view,
      coverageSpectrum: coverageSpectrum.toDomain(),
      isSubscribed: isSubscribed,
    );
  }
}