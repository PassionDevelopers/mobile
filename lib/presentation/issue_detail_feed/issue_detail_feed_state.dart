import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/issue/issue_detail.dart';
import 'package:could_be/domain/entities/comment/major_comment.dart';
import 'package:flutter/cupertino.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final List<MajorComment> majorComments;
  final bool isLoading;
  final bool isEvaluating;
  final bool isMajorCommentsLoading;
  final double fontSize;

  final bool isCommonSummarySpread;
  final bool isBiasComparisonSpread;
  final bool isTabsSpread;
  final bool isSummarySpread;
  final bool isSourceListSpread;

  final Bias? myBias;

  IssueDetailFeedState({
    this.myBias,
    this.isLoading = false,
    this.isMajorCommentsLoading = false,
    this.isEvaluating = false,
    this.majorComments = const [],
    this.issueDetail,
    this.fontSize = 18,
    this.isCommonSummarySpread = false,
    this.isBiasComparisonSpread = true,
    this.isTabsSpread = false,
    this.isSummarySpread = true,
    this.isSourceListSpread = true,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
    bool? isMajorCommentsLoading,
    bool? isEvaluating,
    int? pageCount,
    double? fontSize,
    bool? isCommonSummarySpread,
    bool? isBiasComparisonSpread,
    bool? isTabsSpread,
    bool? isSummarySpread,
    bool? isSourceListSpread,
    List<MajorComment>? majorComments,
    Bias? myBias,
  }) {
    return IssueDetailFeedState(
      myBias: myBias ?? this.myBias,
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
      isMajorCommentsLoading: isMajorCommentsLoading ?? this.isMajorCommentsLoading,
      isEvaluating: isEvaluating ?? this.isEvaluating,
      fontSize: fontSize ?? this.fontSize,
      majorComments: majorComments ?? this.majorComments,
      isCommonSummarySpread: isCommonSummarySpread ?? this.isCommonSummarySpread,
      isBiasComparisonSpread: isBiasComparisonSpread ?? this.isBiasComparisonSpread,
      isTabsSpread: isTabsSpread ?? this.isTabsSpread,
      isSummarySpread: isSummarySpread ?? this.isSummarySpread,
      isSourceListSpread: isSourceListSpread ?? this.isSourceListSpread,
    );
  }
}