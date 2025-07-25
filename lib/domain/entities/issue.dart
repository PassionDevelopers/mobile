
import 'package:could_be/domain/entities/issue_tag.dart';

import 'coverage_spectrum.dart';

class Issue{
  final String id;
  final String title;
  final String category;
  final String summary;
  final bool isRead;

  final DateTime createdAt;
  final DateTime? updatedAt;

  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;

  final List<String> keywords;
  final String? imageUrl;
  final int view;
  final CoverageSpectrum coverageSpectrum;
  final bool isSubscribed;

  final String? userEvaluatedPerspective;

  final List<IssueTag> tags;

  Issue({
    required this.id,
    required this.summary,
    required this.tags,
    required this.title,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.keywords,
    required this.imageUrl,
    required this.view,
    required this.coverageSpectrum,
    required this.isSubscribed,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    this.userEvaluatedPerspective,
  });

  Issue copyWith({
        String? id,
        String? title,
        bool? isRead,
        String? category,
        String? summary,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? leftLikeCount,
        int? centerLikeCount,
        int? rightLikeCount,
        List<String>? keywords,
        String? imageUrl,
        int? view,
        CoverageSpectrum? coverageSpectrum,
        bool? isSubscribed,
        required String? userEvaluatedPerspective,
        List<IssueTag>? tags
    }){
    return Issue(
      id: id ?? this.id,
      isRead: isRead ?? this.isRead,
      title: title ?? this.title,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      leftLikeCount: leftLikeCount ?? this.leftLikeCount,
      centerLikeCount: centerLikeCount ?? this.centerLikeCount,
      rightLikeCount: rightLikeCount ?? this.rightLikeCount,
      keywords: keywords ?? this.keywords,
      imageUrl: imageUrl ?? this.imageUrl,
      view: view ?? this.view,
      coverageSpectrum: coverageSpectrum ?? this.coverageSpectrum,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      userEvaluatedPerspective: userEvaluatedPerspective,
      tags: tags ?? this.tags
    );
  }
}