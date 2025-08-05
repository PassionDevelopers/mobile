import 'package:could_be/domain/entities/issue_detail.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final bool isLoading;
  final bool isEvaluating;
  final double fontSize;

  final bool isCommonSummarySpread;


  IssueDetailFeedState({
    this.isLoading = false,
    this.isEvaluating = false,
    this.issueDetail,
    this.fontSize = 18,
    this.isCommonSummarySpread = false,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
    bool? isEvaluating,
    int? pageCount,
    double? fontSize,
    bool? isCommonSummarySpread,
  }) {
    return IssueDetailFeedState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
      isEvaluating: isEvaluating ?? this.isEvaluating,
      fontSize: fontSize ?? this.fontSize,
      isCommonSummarySpread: isCommonSummarySpread ?? this.isCommonSummarySpread,
    );
  }
}