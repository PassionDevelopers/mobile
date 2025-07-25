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

  SourceDetail copyWith({
    String? id,
    String? name,
    String? description,
    String? perspective,
    String? url,
    String? logoUrl,
    Articles? recentArticles,
    bool? isSubscribed,
    String? userEvaluatedPerspective,
    String? aiEvaluatedPerspective,
    String? expertEvaluatedPerspective,
    int? publicEvaluatedPerspective,
    int? totalIssuesCount,
    bool? notificationEnabled,
  }) {
    return SourceDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      perspective: perspective ?? this.perspective,
      url: url ?? this.url,
      logoUrl: logoUrl ?? this.logoUrl,
      recentArticles: recentArticles ?? this.recentArticles,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      userEvaluatedPerspective: userEvaluatedPerspective ?? this.userEvaluatedPerspective,
      aiEvaluatedPerspective: aiEvaluatedPerspective ?? this.aiEvaluatedPerspective,
      expertEvaluatedPerspective: expertEvaluatedPerspective ?? this.expertEvaluatedPerspective,
      publicEvaluatedPerspective: publicEvaluatedPerspective ?? this.publicEvaluatedPerspective,
      totalIssuesCount: totalIssuesCount ?? this.totalIssuesCount,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }
}