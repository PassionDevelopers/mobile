import 'package:could_be/domain/useCases/fetch_issues_use_case.dart';
import 'package:flutter/cupertino.dart';
import '../../../domain/entities/issue.dart';
import '../issue_type.dart';

class IssueListViewModel with ChangeNotifier {
  final FetchIssuesUseCase _fetchIssuesUseCase;
  final IssueType _issueType;

  //상태
  List<Issue> _issueList = [];
  bool hasMore = false;
  String lastIssueId = '';

  List<Issue> get issues => List.unmodifiable(_issueList);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  IssueListViewModel({
    required FetchIssuesUseCase fetchIssuesUseCase,
    required IssueType issueType,
  })  : _fetchIssuesUseCase = fetchIssuesUseCase,
        _issueType = issueType {
    _fetchIssues();
  }

  void _fetchIssues() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await _fetchIssuesByType();
      _issueList = result.issues;
      hasMore = result.hasMore;
      lastIssueId = result.lastIssueId;
    } catch (e) {
      // 에러 처리 로직 추가
      print('Error fetching ${_issueType.name} issues: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> _fetchIssuesByType() async {
    switch (_issueType) {
      case IssueType.daily:
        return await _fetchIssuesUseCase.fetchDailyIssues();
      case IssueType.blindSpot:
        return await _fetchIssuesUseCase.fetchBlindSpotIssues();
      case IssueType.forYou:
        return await _fetchIssuesUseCase.fetchForYouIssues();
      case IssueType.hot:
        return await _fetchIssuesUseCase.fetchHotIssues();
    }
  }
} 