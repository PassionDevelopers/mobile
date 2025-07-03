import 'package:could_be/domain/entities/issue_detail.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final bool isLoading;


  IssueDetailFeedState({
    this.isLoading = false,
    this.issueDetail,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
  }) {
    return IssueDetailFeedState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}