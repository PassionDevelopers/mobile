import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/user/user_profile.dart';

class MajorComment {
  final String id;
  final UserProfile userProfile;
  final String content;
  final DateTime createdAt;
  final bool isDeleted;
  final List<String> source;
  final Bias bias;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final bool isLiked;

  MajorComment({
    required this.userProfile,
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isDeleted,
    required this.source,
    required this.bias,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.isLiked,
  });

  MajorComment copyWith({
    String? id,
    UserProfile? userProfile,
    String? content,
    DateTime? createdAt,
    bool? isDeleted,
    List<String>? source,
    Bias? bias,
    int? leftLikeCount,
    int? centerLikeCount,
    int? rightLikeCount,
    bool? isLiked,
  }) {
    return MajorComment(
      id: id ?? this.id,
      userProfile: userProfile ?? this.userProfile,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
      source: source ?? this.source,
      bias: bias ?? this.bias,
      leftLikeCount: leftLikeCount ?? this.leftLikeCount,
      centerLikeCount: centerLikeCount ?? this.centerLikeCount,
      rightLikeCount: rightLikeCount ?? this.rightLikeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

