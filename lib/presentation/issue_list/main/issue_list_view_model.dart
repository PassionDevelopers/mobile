import 'package:could_be/domain/useCases/fetch_issues_use_case.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_state.dart';
import 'package:flutter/cupertino.dart';
import '../issue_type.dart';

class IssueListViewModel with ChangeNotifier {
  final FetchIssuesUseCase _fetchIssuesUseCase;
  final IssueType _issueType;

  //상태
  IssueListState _state = IssueListState();
  IssueListState get state => _state;

  IssueListViewModel({
    required FetchIssuesUseCase fetchIssuesUseCase,
    required IssueType issueType,
  })  : _fetchIssuesUseCase = fetchIssuesUseCase,
        _issueType = issueType {
    _fetchIssues();
  }

  void _fetchIssues() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssuesByType();
    _state = state.copyWith(
      issueList: result.issues,
      hasMore: result.hasMore,
      lastIssueId: result.lastIssueId,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<dynamic> _fetchIssuesByType() async {
    switch (_issueType) {
      case IssueType.daily:
        return await _fetchIssuesUseCase.fetchDailyIssues();
      case IssueType.blindSpotLeft:
        return await _fetchIssuesUseCase.fetchBlindSpotLeftIssues();
      case IssueType.blindSpotRight:
        return await _fetchIssuesUseCase.fetchBlindSpotRightIssues();
      case IssueType.forYou:
        return await _fetchIssuesUseCase.fetchForYouIssues();
      case IssueType.hot:
        return await _fetchIssuesUseCase.fetchHotIssues();
      case IssueType.watchHistroy:
        return await _fetchIssuesUseCase.fetchWatchHistoryIssues();
      case IssueType.subscribed:
        return await _fetchIssuesUseCase.fetchSubscribedIssues();
    }
  }
} 