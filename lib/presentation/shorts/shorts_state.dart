import 'package:could_be/domain/entities/issue_detail.dart';

class IssueDetailState{

  final IssueDetail? issueDetail;
  final bool isLoading;


  IssueDetailState({
    this.isLoading = false,
    this.issueDetail,
  });

  IssueDetailState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
  }) {
    return IssueDetailState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}