import 'articles.dart';

class SourceDetail {
  final String id;
  final String name;
  final String description;
  final String perspective;
  final String url;
  final String logoUrl;
  final Articles recentArticles;
  final bool isSubscribed;
  final String? userEvaluatedPerspective;
  final String aiEvaluatedPerspective;
  final String? expertEvaluatedPerspective;
  final int? publicEvaluatedPerspective;
  final int totalIssuesCount;
  final bool notificationEnabled;

  SourceDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.perspective,
    required this.url,
    required this.logoUrl,
    required this.recentArticles,
    required this.isSubscribed,
    required this.userEvaluatedPerspective,
    required this.aiEvaluatedPerspective,
    required this.expertEvaluatedPerspective,
    required this.publicEvaluatedPerspective,
    required this.totalIssuesCount,
    required this.notificationEnabled,
  });
}