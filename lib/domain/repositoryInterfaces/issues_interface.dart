import 'package:could_be/domain/entities/issue_query_params.dart';

import '../entities/issues.dart';

abstract class IssuesRepository{
  Future<Issues> fetchQueryParamIssues(IssueQueryParam issueQueryParam, {String? lastIssueId});
  Future<Issues> fetchDailyIssues({String? lastIssueId});
  Future<Issues> fetchHotIssues({String? lastIssueId});
  Future<Issues> fetchBlindSpotLeftIssues({String? lastIssueId});
  Future<Issues> fetchBlindSpotRightIssues({String? lastIssueId});
  Future<Issues> fetchForYouIssues({String? lastIssueId});
  Future<Issues> fetchWatchHistoryIssues({String? lastIssueId});
  Future<Issues> fetchSubscribedIssues({String? lastIssueId});

  Future<Issues> fetchIssuesByTopicId(String topicId, {String? lastIssueId});
  Future<Issues> fetchSubscribedTopicIssues({String? lastIssueId});

  Future<Issues> fetchIssuesEvaluated({String? lastIssueId});
}