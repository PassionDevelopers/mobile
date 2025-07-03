import 'dart:developer';
import 'package:could_be/domain/useCases/manage_issue_subscription_use_case.dart';
import 'package:could_be/presentation/shorts/shorts_state.dart';
import 'package:flutter/cupertino.dart';
import '../../core/components/alert/toast.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';

class
ShortsViewModel with ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  final ManageIssueSubscriptionUseCase manageIssueSubscriptionUseCase;
  final String issueId;

  //상태
  IssueDetailState _state = IssueDetailState();

  IssueDetailState get state => _state;

  ShortsViewModel({
    required this.issueId,
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required this.manageIssueSubscriptionUseCase,
  }) : _fetchIssueDetailUseCase = fetchIssueDetailUseCase {
    _fetchIssueDetailById();
  }

  void _fetchIssueDetailById() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);

    _state = state.copyWith(issueDetail: result, isLoading: false);
    notifyListeners();
  }

  void manageIssueSubscription() async {
    if (state.issueDetail!.isSubscribed) {
      await manageIssueSubscriptionUseCase.unsubscribeIssueByIssueId(issueId);
    } else {
      await manageIssueSubscriptionUseCase.subscribeIssueByIssueId(issueId);
    }
    showMyToast(msg: state.issueDetail!.isSubscribed
              ? "관심 이슈에서 해제하였습니다."
              : "관심 이슈로 등록하였습니다.",
    );
    _state = state.copyWith(
      issueDetail: state.issueDetail!.copyWith(
        isSubscribed: !state.issueDetail!.isSubscribed,
      ),
    );
    log('issueId: $issueId, isSubscribed: ${state.issueDetail!.isSubscribed}');
    notifyListeners();
  }
}
