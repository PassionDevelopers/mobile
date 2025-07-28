class Notice{
  final String id;
  final String title;
  final String? content;
  final bool isImportant;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.isImportant,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}