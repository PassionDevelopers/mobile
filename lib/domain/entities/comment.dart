
import 'package:could_be/domain/entities/reply.dart';
import 'package:could_be/domain/entities/user_profile.dart';

class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isDeleted;
  final List<String> source;
  final bool isShowReplies;

  final UserProfile userProfile;

  final bool isLiked;
  final List<Reply> replies;

  const Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    this.isDeleted = false,
    this.source = const [],
    required this.userProfile,
    this.isLiked = false,
    this.replies = const [],
    this.isShowReplies = false,
  });

  Comment copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isDeleted,
    List<String>? source,
    UserProfile? userProfile,
    bool? isLiked,
    bool? isMyComment,
    List<Reply>? replies,
    bool? isShowReplies,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isDeleted: isDeleted ?? this.isDeleted,
      source: source ?? this.source,
      userProfile: userProfile ?? this.userProfile,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
      isShowReplies: isShowReplies ?? this.isShowReplies,
    );
  }
}