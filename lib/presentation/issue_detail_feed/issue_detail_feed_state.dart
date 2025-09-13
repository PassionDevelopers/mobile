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
  final bool isMajorCommentsSpread;
  final bool isSourceListSpread;

  final Bias? myBias;

  final bool hasShowedBiasButton;
  final bool isBiasButtonSpread;

  IssueDetailFeedState({
    this.myBias,
    this.isLoading = false,
    this.isMajorCommentsLoading = false,
    this.isEvaluating = false,
    this.majorComments = const [],
    this.issueDetail,
    this.fontSize = 14,
    this.isCommonSummarySpread = false,
    this.isBiasComparisonSpread = true,
    this.isTabsSpread = false,
    this.isSummarySpread = true,
    this.isMajorCommentsSpread = true,
    this.isSourceListSpread = true,
    this.hasShowedBiasButton = false,
    this.isBiasButtonSpread = false,
  });

  IssueDetailFeedState copyWith({
    IssueDetail? issueDetail,
    bool? isLoading,
    bool? isMajorCommentsLoading,
    bool? isEvaluating,
    double? fontSize,
    bool? isCommonSummarySpread,
    bool? isBiasComparisonSpread,
    bool? isTabsSpread,
    bool? isSummarySpread,
    bool? isSourceListSpread,
    bool? isMajorCommentsSpread,
    List<MajorComment>? majorComments,
    Bias? myBias,
    bool? hasShowedBiasButton,
    bool? isBiasButtonSpread,
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
      isMajorCommentsSpread: isMajorCommentsSpread ?? this.isMajorCommentsSpread,
      isSourceListSpread: isSourceListSpread ?? this.isSourceListSpread,
      hasShowedBiasButton: hasShowedBiasButton ?? this.hasShowedBiasButton,
      isBiasButtonSpread: isBiasButtonSpread ?? this.isBiasButtonSpread,
    );
  }
}