import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/comment/reply.dart';
import 'package:could_be/domain/entities/user/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_dto.g.dart';

@JsonSerializable()
class ReplyDto {
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

  ReplyDto(
    this.id,
    this.userId,
    this.content,
    this.createdAt,
    this.likeCount,
    this.isDeleted,
    this.source,
    this.nickname,
    this.imageUrl,
    this.isLiked,
  );

  factory ReplyDto.fromJson(Map<String, dynamic> json) =>
      _$ReplyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyDtoToJson(this);
}

extension ReplyDtx on ReplyDto {
  Reply toDomain(Bias bias) {
    return Reply(
      id: id,
      content: content,
      createdAt: createdAt,
      likeCount: likeCount,
      isDeleted: isDeleted,
      source: source,
      userProfile: UserProfile(bias: bias, userId: userId, nickname: nickname, imageUrl: imageUrl),
      isLiked: isLiked,
    );
  }
}

