import '../entities/issue.dart';

abstract class IssueRepository{

  Future<List<Issue>> fetchDailyIssues();

}