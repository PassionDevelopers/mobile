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

  Future<Issues> fetchBlindSpotIssues() async {
    return _issuesRepository.fetchBlindSpotIssues();
  }

  Future<Issues> fetchForYouIssues() async {
    return _issuesRepository.fetchForYouIssues();
  }
}