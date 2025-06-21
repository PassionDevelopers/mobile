
import 'coverage_spectrum.dart';

class Issue{
  final String id;
  final String title;
  final String category;
  final String summary;

  final DateTime createdAt;
  final DateTime updatedAt;


  final List<String> keywords;
  final String? imageUrl;
  final int view;
  final CoverageSpectrum coverageSpectrum;

  Issue({
    required this.id,
    required this.summary,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.keywords,
    this.imageUrl,
    required this.view,
    required this.coverageSpectrum,
  });

  List<Object> get props => [
    id,
    title,
    category,
    summary,
    createdAt,
    updatedAt,
    keywords,
    imageUrl ?? '',
    view,
    coverageSpectrum
  ];

  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}년 전';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}달 전';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}