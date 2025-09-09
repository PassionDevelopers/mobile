import 'issue.dart';

class Issues{
  final List<Issue> issues;
  final bool hasMore;
  final String? lastIssueId;

  Issues({
    required this.issues,
    required this.hasMore,
    required this.lastIssueId,
  });
}