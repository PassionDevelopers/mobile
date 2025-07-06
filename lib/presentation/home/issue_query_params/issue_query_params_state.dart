import 'package:could_be/domain/entities/issue_query_params.dart';

class IssueQueryParamsState {
  bool isLoading;
  int selectedIndex = 0;
  IssueQueryParams? issueQueryParams;

  IssueQueryParamsState({
    this.isLoading = false,
    this.selectedIndex = 0,
    this.issueQueryParams,
  });

  IssueQueryParamsState copyWith({
    bool? isLoading,
    int? selectedIndex,
    IssueQueryParams? issueQueryParams,
  }) {
    return IssueQueryParamsState(
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      issueQueryParams: issueQueryParams ?? this.issueQueryParams,
    );
  }
}