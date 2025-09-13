import 'package:could_be/data/dto/issue/issue_dto.dart';
import 'package:could_be/domain/entities/issue/issues_with_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issues_with_category_dto.g.dart';

@JsonSerializable()
class IssuesWithCategoryDto {
  final List<IssueDTO> issues;
  final bool hasMore;
  final String? lastIssueId;
  final String category;

  IssuesWithCategoryDto(
    this.issues,
    this.hasMore,
    this.lastIssueId,
    this.category,
  );

  factory IssuesWithCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$IssuesWithCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesWithCategoryDtoToJson(this);
}

extension IssuesWithCategoryDtx on IssuesWithCategoryDto {
  IssuesWithCategory toDomain() {
    return IssuesWithCategory(
      issues: issues.map((e) => e.toDomain()).toList(),
      hasMore: hasMore,
      lastIssueId: lastIssueId,
      category: category,
    );
  }
}
