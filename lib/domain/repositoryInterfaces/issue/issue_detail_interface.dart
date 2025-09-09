

import 'package:could_be/domain/entities/issue/issue_detail.dart';

abstract class IssueDetailRepository {
  Future<IssueDetail?> fetchIssueDetailById(String id);
}