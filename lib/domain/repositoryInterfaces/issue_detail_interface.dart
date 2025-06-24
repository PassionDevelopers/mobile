import '../entities/issue_detail.dart';

abstract class IssueDetailRepository {
  Future<IssueDetail?> fetchIssueDetailById(String id);
}