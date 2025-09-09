import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/method/share_dasi_stand.dart';
import 'package:could_be/domain/entities/comment/major_comment.dart';
import 'package:could_be/domain/entities/user/user_profile.dart';
import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/issue/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/issue/manage_issue_subscription_use_case.dart';
import 'package:could_be/domain/useCases/user/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';
import 'package:could_be/presentation/community/report/report_bottom_sheet.dart';
import 'package:could_be/presentation/log_in/login_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/components/alert/toast.dart';
import '../../core/method/bias/bias_enum.dart';
import '../../domain/useCases/issue/fetch_whole_issue_use_case.dart';
import 'issue_detail_feed_state.dart';

class IssueDetailViewModel with ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  final ManageIssueSubscriptionUseCase manageIssueSubscriptionUseCase;
  final ManageIssueEvaluationUseCase manageIssueEvaluationUseCase;
  final TrackUserActivityUseCase trackUserActivityUseCase;
  final FirebaseLoginUseCase firebaseLoginUseCase;
  final CommentUseCase commentUseCase;
  final ManageUserProfileUseCase manageUserProfileUseCase;

  //상태
  IssueDetailFeedState _state = IssueDetailFeedState();

  IssueDetailFeedState get state => _state;

  String issueId;
  final _majorCommentsController = StreamController();
  Stream get majorCommentsStream => _majorCommentsController.stream;

  IssueDetailViewModel({
    required this.issueId,
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required this.trackUserActivityUseCase,
    required this.manageIssueEvaluationUseCase,
    required this.manageIssueSubscriptionUseCase,
    required this.firebaseLoginUseCase,
    required this.manageUserProfileUseCase,
    required this.commentUseCase,
  }) : _fetchIssueDetailUseCase = fetchIssueDetailUseCase {
    fetchMyBias();
    fetchIssueDetailById(issueId);
    fetchMajorComments();
  }

  void showReportDialog(BuildContext context, String commentId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReportBottomSheet(
          commentId: commentId,
          onReportSuccess: () {},
        );
      },
    );
  }

  void deleteMajorComment(BuildContext context, String commentId) async {
    showConfirm(context: context, msg: '정말로 대표 의견으로 등록된 댓글을 삭제하시겠습니까? 많은 사용자들이 이 댓글에 공감하고 있습니다.',
      callback: (){
        _state = state.copyWith(majorComments: state.majorComments.where((comment) => comment.id != commentId).toList());
        notifyListeners();
        commentUseCase.deleteComment(commentId);
    });
  }

  void likeMajorComment(String commentId) async {
    if(state.myBias == null) return;
    _state = state.copyWith(majorComments: state.majorComments.map((comment) {
      if (comment.id == commentId) {
        if(state.myBias == Bias.right){
          return comment.copyWith(
            isLiked: !comment.isLiked,
            leftLikeCount: comment.isLiked? comment.leftLikeCount -1 : comment.leftLikeCount + 1,
          );
        }else if(state.myBias == Bias.left){
          return comment.copyWith(
            isLiked: !comment.isLiked,
            rightLikeCount: comment.isLiked? comment.rightLikeCount -1 : comment.rightLikeCount + 1,
          );
        }else if(state.myBias == Bias.center){
          return comment.copyWith(
            isLiked: !comment.isLiked,
            centerLikeCount: comment.isLiked? comment.centerLikeCount -1 : comment.centerLikeCount + 1,
          );
        }
      }
      return comment;
    }).toList());
    notifyListeners();
    await commentUseCase.toggleLikeComment(commentId);
  }

  void fetchMyBias() async {
    final UserProfile userProfile = await manageUserProfileUseCase.fetchUserProfile();
    _state = state.copyWith(myBias: userProfile.bias);
    notifyListeners();
  }

  void fetchMajorComments() async {
    _state = state.copyWith(isMajorCommentsLoading: true);
    notifyListeners();
    try {
      final majorComments = await commentUseCase.fetchMajorComments(issueId);
      _state = state.copyWith(majorComments: majorComments);
    } catch (e) {
      log('주요 댓글 불러오기 실패: $e');
    }
    _majorCommentsController.add(null);
    _state = state.copyWith(isMajorCommentsLoading: false);
    notifyListeners();
  }

  List<MajorComment> getMajorComments({required Bias bias}) {
    if(state.majorComments.isEmpty) return [];
    log("Get Major Comments for bias: $bias, total comments: ${state.majorComments.length}");
    return state.majorComments.where((comment) => comment.bias == bias ).toList();
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
