class Source {
  final String id;
  final String name;
  final String perspective;
  final String logoUrl;
  final bool isSubscribed;

  Source({
    required this.id,
    required this.name,
    required this.perspective,
    required this.logoUrl,
    required this.isSubscribed,
  });

  Source copyWith({
    String? id,
    String? name,
    String? perspective,
    String? logoUrl,
    bool? isSubscribed,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
      perspective: perspective ?? this.perspective,
      logoUrl: logoUrl ?? this.logoUrl,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
} 