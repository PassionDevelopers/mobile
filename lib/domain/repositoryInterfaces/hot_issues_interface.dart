import 'package:could_be/domain/entities/hot_issues.dart';

abstract class HotIssuesRepository{
  Future<HotIssues> fetchHotIssues({
    String? lastIssueId,
  });
}