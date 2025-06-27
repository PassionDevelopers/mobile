import 'coverage_spectrum.dart';

class IssueDetail {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String? imageUrl;
  final List<String> keywords;
  final DateTime createdAt;
  final int view;
  final CoverageSpectrum coverageSpectrum;
  final DateTime? updatedAt;
  final String leftSummary;
  final String centerSummary;
  final String rightSummary;
  final String biasComparison;
  final List<String> leftKeywords;
  final List<String> centerKeywords;
  final List<String> rightKeywords;
  final List<String> nextIssueIds;
  final bool isSubscribed;

  IssueDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.imageUrl,
    required this.keywords,
    required this.createdAt,
    required this.view,
    required this.coverageSpectrum,
    required this.updatedAt,
    required this.leftSummary,
    required this.centerSummary,
    required this.rightSummary,
    required this.biasComparison,
    required this.leftKeywords,
    required this.centerKeywords,
    required this.rightKeywords,
    required this.nextIssueIds,
    required this.isSubscribed,
  });

  IssueDetail copyWith({
    String? id,
    String? title,
    String? category,
    String? summary,
    String? imageUrl,
    List<String>? keywords,
    DateTime? createdAt,
    int? view,
    CoverageSpectrum? coverageSpectrum,
    DateTime? updatedAt,
    String? leftSummary,
    String? centerSummary,
    String? rightSummary,
    String? biasComparison,
    List<String>? leftKeywords,
    List<String>? centerKeywords,
    List<String>? rightKeywords,
    List<String>? nextIssueIds,
    bool? isSubscribed,
  }) {
    return IssueDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      view: view ?? this.view,
      coverageSpectrum: coverageSpectrum ?? this.coverageSpectrum,
      updatedAt: updatedAt ?? this.updatedAt,
      leftSummary: leftSummary ?? this.leftSummary,
      centerSummary: centerSummary ?? this.centerSummary,
      rightSummary: rightSummary ?? this.rightSummary,
      biasComparison: biasComparison ?? this.biasComparison,
      leftKeywords: leftKeywords ?? this.leftKeywords,
      centerKeywords: centerKeywords ?? this.centerKeywords,
      rightKeywords: rightKeywords ?? this.rightKeywords,
      nextIssueIds: nextIssueIds ?? this.nextIssueIds,
      isSubscribed: isSubscribed ?? this.isSubscribed
    );
  }
} 