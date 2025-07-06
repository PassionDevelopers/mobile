import 'package:could_be/domain/useCases/fetch_issue_query_params_use_case.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_state.dart';
import 'package:flutter/material.dart';

class IssueQueryParamsViewModel extends ChangeNotifier {
  final FetchIssueQueryParamsUseCase _fetchIssueQueryParamsUseCase;

  IssueQueryParamsViewModel({required FetchIssueQueryParamsUseCase fetchIssueQueryParamsUseCase})
      : _fetchIssueQueryParamsUseCase = fetchIssueQueryParamsUseCase {
    fetchIssueQueryParams();
  }

  IssueQueryParamsState _state = IssueQueryParamsState();
  IssueQueryParamsState get state => _state;

  Future<void> fetchIssueQueryParams() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchIssueQueryParamsUseCase.fetchIssueQueryParams();

    _state = state.copyWith(
      issueQueryParams: result,
      isLoading: false,
    );

    notifyListeners();
  }

  void setSelectedIndex(int index) {
    if(index == _state.selectedIndex) return; // 중복 선택 방지
    _state = state.copyWith(selectedIndex: index);
    notifyListeners();
  }
}