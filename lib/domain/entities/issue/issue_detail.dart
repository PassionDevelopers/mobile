import 'package:could_be/domain/entities/issue/issue_tag.dart';

import '../article/articles.dart';
import '../coverage_spectrum.dart';

class IssueDetail {
  final String id;
  final List<IssueTag> tags;
  final String title;
  final String category;
  final String summary;
  final String? commonSummary;
  final String? imageUrl;
  final String? imageSource;
  final List<String> keywords;
  final DateTime createdAt;
  final int view;
  final CoverageSpectrum coverageSpectrum;
  final DateTime? updatedAt;
  final String? userEvaluation;
  final String? leftSummary;
  final String? centerSummary;
  final String? rightSummary;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final String? leftComparison;
  final String? centerComparison;
  final String? rightComparison;
  final List<String>? leftKeywords;
  final List<String>? centerKeywords;
  final List<String>? rightKeywords;
  final List<String> nextIssueIds;
  final bool isSubscribed;
  final Articles articles;
  final int commentsCount;

  IssueDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.commonSummary,
    required this.imageUrl,
    required this.imageSource,
    required this.keywords,
    required this.createdAt,
    required this.view,
    required this.coverageSpectrum,
    required this.updatedAt,
    required this.leftSummary,
    required this.centerSummary,
    required this.rightSummary,
    required this.leftComparison,
    required this.centerComparison,
    required this.rightComparison,
    required this.leftKeywords,
    required this.centerKeywords,
    required this.rightKeywords,
    required this.nextIssueIds,
    required this.isSubscribed,
    required this.articles,
    required this.userEvaluation,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.tags,
    required this.commentsCount,
  });

  IssueDetail copyWith({
    String? id,
    String? title,
    String? category,
    String? summary,
    String? imageUrl,
    String? commonSummary,
    String? imageSource,
    List<String>? keywords,
    DateTime? createdAt,
    int? view,
    List<IssueTag> ? tags,
    CoverageSpectrum? coverageSpectrum,
    DateTime? updatedAt,
    String? leftSummary,
    String? centerSummary,
    String? rightSummary,
    String? leftComparison,
    String? centerComparison,
    String? rightComparison,
    String? biasComparison,
    List<String>? leftKeywords,
    List<String>? centerKeywords,
    List<String>? rightKeywords,
    List<String>? nextIssueIds,
    bool? isSubscribed,
    Articles? articles,
    required String? userEvaluation,
    int? leftLikeCount,
    int? centerLikeCount,
    int? rightLikeCount,
    int? commentsCount,
  }) {
    return IssueDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      commonSummary: commonSummary ?? this.commonSummary,
      imageSource: imageSource ?? this.imageSource,
      imageUrl: imageUrl ?? this.imageUrl,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      view: view ?? this.view,
      tags: tags ?? this.tags,
      coverageSpectrum: coverageSpectrum ?? this.coverageSpectrum,
      updatedAt: updatedAt ?? this.updatedAt,
      leftSummary: leftSummary ?? this.leftSummary,
      centerSummary: centerSummary ?? this.centerSummary,
      rightSummary: rightSummary ?? this.rightSummary,
      leftComparison: leftComparison ?? this.leftComparison,
      centerComparison: centerComparison ?? this.centerComparison,
      rightComparison: rightComparison ?? this.rightComparison,
      leftKeywords: leftKeywords ?? this.leftKeywords,
      centerKeywords: centerKeywords ?? this.centerKeywords,
      rightKeywords: rightKeywords ?? this.rightKeywords,
      nextIssueIds: nextIssueIds ?? this.nextIssueIds,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      articles: articles ?? this.articles,
      userEvaluation: userEvaluation,
      leftLikeCount: leftLikeCount ?? this.leftLikeCount,
      centerLikeCount: centerLikeCount ?? this.centerLikeCount,
      rightLikeCount: rightLikeCount ?? this.rightLikeCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }
} 