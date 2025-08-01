import 'package:could_be/domain/entities/issue_query_params.dart';

import '../entities/issues.dart';
import '../repositoryInterfaces/issues_interface.dart';

class FetchIssuesUseCase{
  final IssuesRepository _issuesRepository;

  const FetchIssuesUseCase(this._issuesRepository);

  Future<Issues> fetchQueryParamIssues(IssueQueryParam issueQueryParam, {String? lastIssueId}) async {
    return await _issuesRepository.fetchQueryParamIssues(issueQueryParam, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchDailyIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchDailyIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchHotIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchHotIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchBlindSpotLeftIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchBlindSpotLeftIssues(lastIssueId: lastIssueId);
  }
  
  Future<Issues> fetchBlindSpotRightIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchBlindSpotRightIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchForYouIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchForYouIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchWatchHistoryIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchWatchHistoryIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedIssues({String? lastIssueId}) async {
    return await _issuesRepository.fetchSubscribedIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedTopicIssuesWhole({String? lastIssueId}) async {
    return await _issuesRepository.fetchSubscribedTopicIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesByTopicId(String topicId, {String? lastIssueId}) async {
    return await _issuesRepository.fetchIssuesByTopicId(topicId, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesEvaluated({String? lastIssueId}) async {
    return await _issuesRepository.fetchIssuesEvaluated(lastIssueId: lastIssueId);
  }
}