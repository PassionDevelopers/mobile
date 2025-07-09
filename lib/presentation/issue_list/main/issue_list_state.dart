

import 'package:could_be/domain/entities/issue_query_params.dart';

import '../../../domain/entities/issue.dart';

class IssueListState{

  final List<Issue> issueList;
  final bool hasMore;
  final String lastIssueId;
  final IssueQueryParam? issueQueryParam;
  final String? topicId;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isEvaluating;

  IssueListState({
    this.issueQueryParam,
    this.topicId,
    this.issueList = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isEvaluating = false,
    this.hasMore = false,
    this.lastIssueId = '',
  });

  IssueListState copyWith({
    List<Issue>? issueList,
    bool? hasMore,
    String? lastIssueId,
    bool? isLoading,
    bool? isLoadingMore,
    IssueQueryParam? issueQueryParam,
    String? topicId,
    bool? isEvaluating,
  }) {
    return IssueListState(
      issueQueryParam: issueQueryParam ?? this.issueQueryParam,
      issueList: issueList ?? this.issueList,
      hasMore: hasMore ?? this.hasMore,
      lastIssueId: lastIssueId ?? this.lastIssueId,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      topicId: topicId ?? this.topicId,
      isEvaluating: isEvaluating ?? this.isEvaluating,
    );
  }
}