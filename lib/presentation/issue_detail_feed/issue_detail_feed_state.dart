import 'package:could_be/domain/entities/issue_detail.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final bool isLoading;
  final bool isEvaluating;
  final double fontSize;


  IssueDetailFeedState({
    this.isLoading = false,
    this.isEvaluating = false,
    this.issueDetail,
    this.fontSize = 18,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
    bool? isEvaluating,
    int? pageCount,
    double? fontSize,
  }) {
    return IssueDetailFeedState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
      isEvaluating: isEvaluating ?? this.isEvaluating,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}