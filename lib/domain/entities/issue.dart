
import 'coverage_spectrum.dart';

class Issue{
  final String id;
  final String title;
  final String category;
  final String summary;

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

  Issue({
    required this.id,
    required this.summary,
    required this.title,
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
  });
}