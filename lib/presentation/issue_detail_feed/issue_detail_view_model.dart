import 'dart:developer';
import 'package:could_be/domain/useCases/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_subscription_use_case.dart';
import 'package:flutter/cupertino.dart';
import '../../core/components/alert/toast.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';
import 'issue_detail_feed_state.dart';

class IssueDetailViewModel with ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  final ManageIssueSubscriptionUseCase manageIssueSubscriptionUseCase;
  final ManageIssueEvaluationUseCase manageIssueEvaluationUseCase;

  //상태
  IssueDetailFeedState _state = IssueDetailFeedState();

  IssueDetailFeedState get state => _state;

  String issueId;

  IssueDetailViewModel({
    required this.issueId,
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required this.manageIssueEvaluationUseCase,
    required this.manageIssueSubscriptionUseCase,
  }) : _fetchIssueDetailUseCase = fetchIssueDetailUseCase {
    fetchIssueDetailById(issueId);
  }

  void setFontSize() {
    _state = state.copyWith(fontSize: state.fontSize == 16 ? 20 : 16);
    notifyListeners();
  }

  void fetchIssueDetailById(String issueId) async {
    this.issueId = issueId;
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);

    _state = state.copyWith(issueDetail: result, isLoading: false,
        pageCount: result != null && result.biasComparison == null? 3 : 4
    );
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
        userEvaluation: state.issueDetail!.userEvaluation,
        isSubscribed: !state.issueDetail!.isSubscribed,
      ),
    );
    notifyListeners();
  }

  void manageIssueEvaluation(Bias bias) async {
    _state = state.copyWith(isEvaluating: true);
    notifyListeners();

    if (state.issueDetail!.userEvaluation != null) {
      if(state.issueDetail!.userEvaluation == bias.toPerspective()) {
        await manageIssueEvaluationUseCase.deleteIssueEvaluation(issueId: issueId);
        _state = state.copyWith(
          issueDetail: state.issueDetail!.copyWith(
              userEvaluation: null,
            leftLikeCount: state.issueDetail!.leftLikeCount - (bias == Bias.left ? 1 : 0),
            rightLikeCount: state.issueDetail!.rightLikeCount - (bias == Bias.right ? 1 : 0),
            centerLikeCount: state.issueDetail!.centerLikeCount - (bias == Bias.center ? 1 : 0),
          ),
        );
      }else{
        await manageIssueEvaluationUseCase.updateIssueEvaluation(issueId: issueId, bias: bias);
        _state = state.copyWith(
          issueDetail: state.issueDetail!.copyWith(
              userEvaluation: bias.toPerspective(),
              leftLikeCount: state.issueDetail!.leftLikeCount + (bias == Bias.left ? 1 : 0) - (state.issueDetail!.userEvaluation == Bias.left.toPerspective() ? 1 : 0),
              rightLikeCount: state.issueDetail!.rightLikeCount + (bias == Bias.right ? 1 : 0) - (state.issueDetail!.userEvaluation == Bias.right.toPerspective() ? 1 : 0),
              centerLikeCount: state.issueDetail!.centerLikeCount + (bias == Bias.center ? 1 : 0) - (state.issueDetail!.userEvaluation == Bias.center.toPerspective() ? 1 : 0),
          ),
        );
      }
    } else {
      await manageIssueEvaluationUseCase.evaluateIssue(issueId: issueId, bias: bias);
      _state = state.copyWith(
        issueDetail: state.issueDetail!.copyWith(
            userEvaluation: bias.toPerspective(),
            leftLikeCount: state.issueDetail!.leftLikeCount + (bias == Bias.left ? 1 : 0),
            rightLikeCount: state.issueDetail!.rightLikeCount + (bias == Bias.right ? 1 : 0),
            centerLikeCount: state.issueDetail!.centerLikeCount + (bias == Bias.center ? 1 : 0),
        ),
      );
    }
    _state = state.copyWith(isEvaluating: false);
    notifyListeners();
  }

}
