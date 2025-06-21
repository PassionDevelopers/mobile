

import '../../../domain/entities/issue.dart';

class IssueListState{

  final List<Issue> issueList;
  final bool hasMore;
  final String lastIssueId;
  final bool isLoading;

  IssueListState({
    this.issueList = const [],
    this.isLoading = false,
    this.hasMore = false,
    this.lastIssueId = '',
  });

  IssueListState copyWith({
    List<Issue>? issueList,
    bool? hasMore,
    String? lastIssueId,
    bool? isLoading,
  }) {
    return IssueListState(
      issueList: issueList ?? this.issueList,
      hasMore: hasMore ?? this.hasMore,
      lastIssueId: lastIssueId ?? this.lastIssueId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}