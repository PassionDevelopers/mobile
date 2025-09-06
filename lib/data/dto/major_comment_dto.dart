import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/major_comment.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'major_comment_dto.g.dart';

@JsonSerializable()
class MajorCommentDto {
  @JsonKey(name: '_id')
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isDeleted;
  final List<String> source;
  final String perspective;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final String? nickname;
  final String? imageUrl;
  final String? userId;
  final bool isLiked;

  MajorCommentDto(
    this.id,
    this.content,
    this.createdAt,
    this.isDeleted,
    this.source,
    this.perspective,
    this.leftLikeCount,
    this.centerLikeCount,
    this.rightLikeCount,
    this.nickname,
    this.imageUrl,
    this.isLiked,
    this.userId,
  );

  factory MajorCommentDto.fromJson(Map<String, dynamic> json) =>
      _$MajorCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MajorCommentDtoToJson(this);
}

extension MajorCommentDtx on MajorCommentDto {
  MajorComment toDomain() {
    return MajorComment(
      id: id,
      content: content,
      createdAt: createdAt,
      isDeleted: isDeleted,
      source: source,
      bias: getBiasFromString(perspective),
      leftLikeCount: leftLikeCount,
      centerLikeCount: centerLikeCount,
      rightLikeCount: rightLikeCount,
      userProfile: UserProfile(
        userId: userId,
        bias: getBiasFromString(perspective),
        nickname: nickname,
        imageUrl: imageUrl,
      ),
      isLiked: isLiked,
    );
  }
}
