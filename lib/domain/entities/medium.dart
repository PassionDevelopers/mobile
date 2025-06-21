import 'articles.dart';
import 'issues.dart';

class Medium {
  final String id;
  final String name;
  final String description;
  final String perspective;
  final String url;
  final String logoUrl;
  final Issues recentIssues;
  final Articles recentArticles;
  final bool isSubscribed;
  final String? userEvaluatedPerspective;

  Medium({
    required this.id,
    required this.name,
    required this.description,
    required this.perspective,
    required this.url,
    required this.logoUrl,
    required this.recentIssues,
    required this.recentArticles,
    required this.isSubscribed,
    required this.userEvaluatedPerspective,
  });
}
