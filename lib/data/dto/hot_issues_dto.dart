import 'package:could_be/data/dto/issue_dto.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_issues_dto.g.dart';

@JsonSerializable()
class HotIssuesDto {
  final List<IssueDTO> issues;
  final bool hasMore;
  final String lastIssueId;
  final DateTime hotTime;

  HotIssuesDto({
    required this.issues,
    required this.hasMore,
    required this.lastIssueId,
    required this.hotTime,
  });

  factory HotIssuesDto.fromJson(Map<String, dynamic> json) =>
      _$HotIssuesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HotIssuesDtoToJson(this);
}

extension HotIssuesDtx on HotIssuesDto {
  HotIssues toDomain() {
    return HotIssues(
      issues: issues.map((issue) => issue.toDomain()).toList(),
      hasMore: hasMore,
      lastIssueId: lastIssueId,
      hotTime: hotTime,
    );
  }
}



