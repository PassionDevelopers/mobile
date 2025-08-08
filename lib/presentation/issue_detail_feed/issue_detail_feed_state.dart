import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:flutter/cupertino.dart';

class IssueDetailFeedState{

  final IssueDetail? issueDetail;
  final bool isLoading;
  final bool isEvaluating;
  final double fontSize;

  final bool isCommonSummarySpread;
  final bool isBiasComparisonSpread;
  final bool isTabsSpread;
  final bool isSummarySpread;
  final bool isSourceListSpread;


  IssueDetailFeedState({
    this.isLoading = false,
    this.isEvaluating = false,
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
    bool? isEvaluating,
    int? pageCount,
    double? fontSize,
    bool? isCommonSummarySpread,
    bool? isBiasComparisonSpread,
    bool? isTabsSpread,
    bool? isSummarySpread,
    bool? isSourceListSpread,
  }) {
    return IssueDetailFeedState(
      issueDetail: issueDetail ?? this.issueDetail,
      isLoading: isLoading ?? this.isLoading,
      isEvaluating: isEvaluating ?? this.isEvaluating,
      fontSize: fontSize ?? this.fontSize,
      isCommonSummarySpread: isCommonSummarySpread ?? this.isCommonSummarySpread,
      isBiasComparisonSpread: isBiasComparisonSpread ?? this.isBiasComparisonSpread,
      isTabsSpread: isTabsSpread ?? this.isTabsSpread,
      isSummarySpread: isSummarySpread ?? this.isSummarySpread,
      isSourceListSpread: isSourceListSpread ?? this.isSourceListSpread,
    );
  }
}