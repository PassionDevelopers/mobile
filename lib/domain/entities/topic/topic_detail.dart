import '../issue/issues.dart';

class TopicDetail {
  final String id;
  final String name;
  final String category;
  final String description;
  final Issues recentIssues;
  final bool isSubscribed;
  final int totalIssuesCount;
  final int subscribersCount;
  final bool notificationEnabled;

  TopicDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.recentIssues,
    required this.isSubscribed,
    required this.totalIssuesCount,
    required this.subscribersCount,
    required this.notificationEnabled,
  });
}