import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/issues.dart';
import 'issue_dto.dart';
part 'issues_dto.g.dart';

@JsonSerializable()
class IssuesDTO{
  final List<IssueDTO> issues;
  final bool hasMore;
  final String? lastIssueId;

  IssuesDTO({
    required this.issues,
    required this.hasMore,
    this.lastIssueId,
  });

  factory IssuesDTO.fromJson(Map<String, dynamic> json) => _$IssuesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesDTOToJson(this);
}

extension IssuesDtoX on IssuesDTO {
  Issues toDomain() {
    return Issues(
      issues: issues.map((IssueDTO issue) => issue.toDomain()).toList(),
      hasMore: hasMore,
      lastIssueId: lastIssueId,
    );
  }
}

