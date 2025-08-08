import 'dart:developer';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/method/share_dasi_stand.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_subscription_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';
import 'package:could_be/presentation/log_in/login_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/components/alert/toast.dart';
import '../../core/method/bias/bias_enum.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';
import 'issue_detail_feed_state.dart';

class IssueDetailViewModel with ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  final ManageIssueSubscriptionUseCase manageIssueSubscriptionUseCase;
  final ManageIssueEvaluationUseCase manageIssueEvaluationUseCase;
  final TrackUserActivityUseCase trackUserActivityUseCase;
  final FirebaseLoginUseCase firebaseLoginUseCase;

  //상태
  IssueDetailFeedState _state = IssueDetailFeedState();

  IssueDetailFeedState get state => _state;

  String issueId;

  IssueDetailViewModel({
    required this.issueId,
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required this.trackUserActivityUseCase,
    required this.manageIssueEvaluationUseCase,
    required this.manageIssueSubscriptionUseCase,
    required this.firebaseLoginUseCase,
  }) : _fetchIssueDetailUseCase = fetchIssueDetailUseCase {
    fetchIssueDetailById(issueId);
  }



  void share() {
    if (state.issueDetail == null) {
      log("Issue detail is null");
      return;
    }
    shareIssue(
      issueId: state.issueDetail!.id,
      issueTitle: state.issueDetail!.title,
    );
  }

  void spreadCommonSummary() {
    _state = state.copyWith(isCommonSummarySpread: !state.isCommonSummarySpread);
    notifyListeners();
  }

  void spreadBiasComparison() {
    _state = state.copyWith(isBiasComparisonSpread: !state.isBiasComparisonSpread);
    notifyListeners();
  }

  void spreadTabs() {
    _state = state.copyWith(isTabsSpread: !state.isTabsSpread);
    notifyListeners();
  }

  void spreadSummary() {
    _state = state.copyWith(isSummarySpread: !state.isSummarySpread);
    notifyListeners();
  }

  void spreadSourceList() {
    _state = state.copyWith(isSourceListSpread: !state.isSourceListSpread);
    notifyListeners();
  }

  void postDasiScore() async {
    await trackUserActivityUseCase.postDasiScore(
      issueId: issueId,
      score: 1.0,
    );
  }

  void setFontSize() {
    _state = state.copyWith(fontSize: state.fontSize == 18 ? 20 : 18);
    notifyListeners();
  }

  void fetchIssueDetailById(String issueId) async {
    this.issueId = issueId;
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);

    _state = state.copyWith(issueDetail: result, isLoading: false,
        pageCount: result != null && (result.leftComparison == null && result.centerComparison == null && result.rightComparison == null)? 3 : 4
    );
    notifyListeners();
  }

  void manageIssueSubscription(BuildContext context) async {
    if( !firebaseLoginUseCase.isNeedLoginPopUp(context)) {
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
  }

  void manageIssueEvaluation({required BuildContext context, required Bias bias}) async {
    if( !firebaseLoginUseCase.isNeedLoginPopUp(context)){
      _state = state.copyWith(isEvaluating: true);
      notifyListeners();
      await manageIssueEvaluationUseCase.evaluateIssue(issueId: issueId, bias: bias);
      if (state.issueDetail!.userEvaluation != null) {
        if(state.issueDetail!.userEvaluation == bias.toPerspective()) {
          // await manageIssueEvaluationUseCase.deleteIssueEvaluation(issueId: issueId);
          _state = state.copyWith(
            issueDetail: state.issueDetail!.copyWith(
              userEvaluation: null,
              leftLikeCount: state.issueDetail!.leftLikeCount - (bias == Bias.left ? 1 : 0),
              rightLikeCount: state.issueDetail!.rightLikeCount - (bias == Bias.right ? 1 : 0),
              centerLikeCount: state.issueDetail!.centerLikeCount - (bias == Bias.center ? 1 : 0),
            ),
          );
        }else{
          // await manageIssueEvaluationUseCase.updateIssueEvaluation(issueId: issueId, bias: bias);
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

}
