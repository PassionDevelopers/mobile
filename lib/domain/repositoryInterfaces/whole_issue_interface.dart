import '../entities/whole_issue.dart';

abstract class WholeIssueRepository {
  Future<WholeIssue?> fetchWholeIssueById(String id);
}