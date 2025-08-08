class Topic{
  final String id;
  final String name;
  final String category;
  final int? issuesCount;
  final bool isSubscribed;

  Topic({
    required this.id,
    required this.name,
    required this.category,
    required this.issuesCount,
    required this.isSubscribed,
  });

  Topic copyWith({
    String? id,
    String? name,
    String? category,
    int? issuesCount,
    bool? isSubscribed,
  }) {
    return Topic(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      issuesCount: issuesCount ?? this.issuesCount,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
}