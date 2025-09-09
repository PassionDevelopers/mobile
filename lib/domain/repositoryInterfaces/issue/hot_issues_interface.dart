import 'package:could_be/domain/entities/issue/hot_issues.dart';

abstract class HotIssuesRepository{
  Future<HotIssues> fetchHotIssues({
    String? lastIssueId,
  });
}