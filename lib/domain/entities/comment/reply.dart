import 'package:could_be/domain/entities/user/user_profile.dart';

class Reply{
  final String id;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isDeleted;
  final List<String> source;
  final UserProfile userProfile;
  final bool isLiked;

  const Reply({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isDeleted,
    required this.source,
    required this.userProfile,
    required this.isLiked,
  });

  Reply copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isDeleted,
    List<String>? source,
    UserProfile? userProfile,
    bool? isLiked,
  }) {
    return Reply(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isDeleted: isDeleted ?? this.isDeleted,
      source: source ?? this.source,
      userProfile: userProfile ?? this.userProfile,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
