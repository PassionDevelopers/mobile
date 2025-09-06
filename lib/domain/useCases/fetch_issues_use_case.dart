import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issues_interface.dart';
import '../entities/issues.dart';

class FetchIssuesUseCase{
  final IssuesRepository _issuesRepository;

  const FetchIssuesUseCase(this._issuesRepository);

  Future<Issues> fetchQueryParamIssues(IssueQueryParam issueQueryParam, {String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchIssueQueryParams,
      parameters: {
        'query_param': issueQueryParam.queryParam,
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchQueryParamIssues(issueQueryParam, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchDailyIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchDailyIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchDailyIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchHotIssues({String? lastIssueId}) async {
    // 이미 fetch_hot_issues_use_case.dart에서 로깅됨
    return await _issuesRepository.fetchHotIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchBlindSpotLeftIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchBlindSpotLeftIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchBlindSpotLeftIssues(lastIssueId: lastIssueId);
  }
  
  Future<Issues> fetchBlindSpotRightIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchBlindSpotRightIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchBlindSpotRightIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchForYouIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchForYouIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchForYouIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchWatchHistoryIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchWatchHistoryIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchWatchHistoryIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchSubscribedIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchSubscribedIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedTopicIssuesWhole({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchSubscribedTopicIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchSubscribedTopicIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesByTopicId(String topicId, {String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchIssuesByTopicId,
      parameters: {
        AnalyticsParameterKeys.topicId: topicId,
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchIssuesByTopicId(topicId, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesEvaluated({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchEvaluatedIssues,
      parameters: {
        if (lastIssueId != null) 'last_issue_id': lastIssueId,
      },
    );
    return await _issuesRepository.fetchIssuesEvaluated(lastIssueId: lastIssueId);
  }
}