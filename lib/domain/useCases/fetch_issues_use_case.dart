import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';

import '../entities/issues.dart';
import '../repositoryInterfaces/issues_interface.dart';

class FetchIssuesUseCase{
  final IssuesRepository _issuesRepository;

  const FetchIssuesUseCase(this._issuesRepository);

  Future<Issues> fetchQueryParamIssues(IssueQueryParam issueQueryParam, {String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchQueryParamIssues);
    return await _issuesRepository.fetchQueryParamIssues(issueQueryParam, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchDailyIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchDailyIssues);
    return await _issuesRepository.fetchDailyIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchHotIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchHotIssues);
    return await _issuesRepository.fetchHotIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchBlindSpotLeftIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchBlindSpotLeftIssues);
    return await _issuesRepository.fetchBlindSpotLeftIssues(lastIssueId: lastIssueId);
  }
  
  Future<Issues> fetchBlindSpotRightIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchBlindSpotRightIssues);
    return await _issuesRepository.fetchBlindSpotRightIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchForYouIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchForYouIssues);
    return await _issuesRepository.fetchForYouIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchWatchHistoryIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchWatchHistoryIssues);
    return await _issuesRepository.fetchWatchHistoryIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedIssues({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSubscribedIssues);
    return await _issuesRepository.fetchSubscribedIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchSubscribedTopicIssuesWhole({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSubscribedTopicIssues);
    return await _issuesRepository.fetchSubscribedTopicIssues(lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesByTopicId(String topicId, {String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchIssuesByTopicId);
    return await _issuesRepository.fetchIssuesByTopicId(topicId, lastIssueId: lastIssueId);
  }

  Future<Issues> fetchIssuesEvaluated({String? lastIssueId}) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchIssuesEvaluated);
    return await _issuesRepository.fetchIssuesEvaluated(lastIssueId: lastIssueId);
  }
}