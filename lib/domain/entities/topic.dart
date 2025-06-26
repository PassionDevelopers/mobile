class Topic{
  final String id;
  final String name;
  final String category;
  final int issuesCount;
  final bool isSubscribed;

  Topic({
    required this.id,
    required this.name,
    required this.category,
    required this.issuesCount,
    required this.isSubscribed,
  });
}