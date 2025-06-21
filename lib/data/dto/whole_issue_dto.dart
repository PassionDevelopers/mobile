import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/whole_issue.dart';
import 'articles_dto.dart';
import 'issue_detail_dto.dart';
part 'whole_issue_dto.g.dart';

@JsonSerializable()
class WholeIssueDTO{
  final IssueDetailDTO issue;
  final ArticlesDTO articles;

  WholeIssueDTO({
    required this.issue,
    required this.articles
  });

  factory WholeIssueDTO.fromJson(Map<String, dynamic> json) => _$WholeIssueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WholeIssueDTOToJson(this);

}

extension WholeIssueDtx on WholeIssueDTO {
  // Converts the DTO to a domain entity
  WholeIssue toDomain() {
    return WholeIssue(
      issue: issue.toDomain(),
      articles: articles.toDomain(),
    );
  }
}