class Topic{
  final String id;
  final String name;
  final List<String> categories;
  final int issuesCount;
  final bool isSubscribed;

  Topic({
    required this.id,
    required this.name,
    required this.categories,
    required this.issuesCount,
    required this.isSubscribed,
  });
}