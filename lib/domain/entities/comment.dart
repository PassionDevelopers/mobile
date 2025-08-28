
import 'package:could_be/domain/entities/user_profile.dart';

class Comment {
  final String id;
  final String content;
  final UserProfile author;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;
  final String? parentId;
  final List<Comment> replies;

  const Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
    this.likeCount = 0,
    this.isLiked = false,
    this.parentId,
    this.replies = const [],
  });

  Comment copyWith({
    String? id,
    String? content,
    UserProfile? author,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
    String? parentId,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      parentId: parentId ?? this.parentId,
      replies: replies ?? this.replies,
    );
  }

  bool get isReply => parentId != null;
}