import 'package:could_be/domain/useCases/fetch_hot_issues_use_case.dart';
import 'package:could_be/presentation/hot_issue/hot_issue_state.dart';
import 'package:flutter/cupertino.dart';

class HotIssuesViewModel with ChangeNotifier{
  final FetchHotIssuesUseCase _fetchHotIssuesUseCase;
  HotIssuesViewModel({required FetchHotIssuesUseCase fetchHotIssuesUseCase})
      : _fetchHotIssuesUseCase = fetchHotIssuesUseCase{
    fetchHotIssues();
  }

  HotIssuesState _state = HotIssuesState();
  HotIssuesState get state => _state;

  Future<void> fetchHotIssues({String? lastIssueId}) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final hotIssues = await _fetchHotIssuesUseCase.fetchHotIssues(lastIssueId: lastIssueId);
      _state = _state.copyWith(hotIssues: hotIssues, isLoading: false);
    } catch (e) {
      // Handle error
      _state = _state.copyWith(isLoading: false);
      rethrow; // or handle the error as needed
    }

    notifyListeners();
  }


}