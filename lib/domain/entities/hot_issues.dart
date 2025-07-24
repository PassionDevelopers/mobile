import 'package:could_be/domain/entities/issue.dart';

class HotIssues{
  final List<Issue> issues;
  final bool hasMore;
  final String lastIssueId;
  final DateTime hotTime;

  HotIssues({
    required this.issues,
    required this.hasMore,
    required this.lastIssueId,
    required this.hotTime,
  });
}