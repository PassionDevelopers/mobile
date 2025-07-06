import 'package:could_be/domain/entities/issue_detail.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final bool isLoading;
  final bool isEvaluating;
  final int pageCount;


  IssueDetailFeedState({
    this.isLoading = false,
    this.isEvaluating = false,
    this.issueDetail,
    this.pageCount = 4,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
    bool? isEvaluating,
    int? pageCount,
  }) {
    return IssueDetailFeedState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
      isEvaluating: isEvaluating ?? this.isEvaluating,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}