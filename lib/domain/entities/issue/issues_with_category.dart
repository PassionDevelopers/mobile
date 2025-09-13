import 'issue.dart';

class IssuesWithCategory {
  final List<Issue> issues;
  final bool hasMore;
  final String? lastIssueId;
  final String category;

  IssuesWithCategory({
    required this.issues,
    required this.hasMore,
    required this.lastIssueId,
    required this.category,
  });

}