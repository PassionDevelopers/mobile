import 'package:could_be/domain/entities/issue_detail.dart';

class ShortsState{

  final IssueDetail? issueDetail;
  final bool isLoading;


  ShortsState({
    this.isLoading = false,
    this.issueDetail,
  });

  ShortsState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
  }) {
    return ShortsState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}