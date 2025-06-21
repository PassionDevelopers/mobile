import 'coverage_spectrum.dart';

class IssueDetail {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String imageUrl;
  final List<String> keywords;
  final DateTime createdAt;
  final int view;
  final CoverageSpectrum coverageSpectrum;
  final DateTime updatedAt;
  final String leftSummary;
  final String centerSummary;
  final String rightSummary;
  final String biasComparison;
  final List<String> leftKeywords;
  final List<String> centerKeywords;
  final List<String> rightKeywords;

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
  });

  String getDate() {
    return createdAt.toLocal().toString().split(' ')[0];
  }

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