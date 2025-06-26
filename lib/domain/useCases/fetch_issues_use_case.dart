import '../entities/issues.dart';
import '../repositoryInterfaces/issues_interface.dart';

class FetchIssuesUseCase{
  final IssuesRepository _issuesRepository;

  const FetchIssuesUseCase(this._issuesRepository);

  Future<Issues> fetchDailyIssues() async {
    return _issuesRepository.fetchDailyIssues();
  }

  Future<Issues> fetchHotIssues() async {
    return _issuesRepository.fetchHotIssues();
  }

  Future<Issues> fetchBlindSpotLeftIssues() async {
    return _issuesRepository.fetchBlindSpotLeftIssues();
  }
  Future<Issues> fetchBlindSpotRightIssues() async {
    return _issuesRepository.fetchBlindSpotRightIssues();
  }

  Future<Issues> fetchForYouIssues() async {
    return _issuesRepository.fetchForYouIssues();
  }

  Future<Issues> fetchWatchHistoryIssues() async {
    return _issuesRepository.fetchWatchHistoryIssues();
  }

  Future<Issues> fetchSubscribedIssues() async {
    return _issuesRepository.fetchSubscribedIssues();
  }

  Future<Issues> fetchSubscribedTopicIssuesWhole() async {
    return _issuesRepository.fetchSubscribedTopicIssues();
  }

  Future<Issues> fetchIssuesByTopicId(String topicId) async {
    return _issuesRepository.fetchIssuesByTopicId(topicId);
  }
}