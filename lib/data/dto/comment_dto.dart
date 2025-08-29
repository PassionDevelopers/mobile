import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/data/dto/reply_dto.dart';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_dto.g.dart';

@JsonSerializable()
class CommentDto {
  @JsonKey(name: '_id')
  final String id;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isDeleted;
  final List<String> source;
  final String? userId;
  final String? nickname;
  final String? imageUrl;
  final bool isLiked;
  final List<ReplyDto> replies;

  CommentDto({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isDeleted,
    required this.source,
    this.userId,
    this.nickname,
    this.imageUrl,
    required this.isLiked,
    required this.replies,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}

extension CommentDtx on CommentDto{
  Comment toDomain({required Bias bias}) {
    return Comment(
      id: id,
      content: content,
      createdAt: createdAt,
      likeCount: likeCount,
      isDeleted: isDeleted,
      source: source,
      userProfile: UserProfile(userId: userId, nickname: nickname, bias: bias, imageUrl: imageUrl, ),
      isLiked: isLiked,
      replies: replies.map((e) => e.toDomain(bias)).toList(),
    );
  }
}
