import 'package:json_annotation/json_annotation.dart';

part 'major_comment_dto.g.dart';

@JsonSerializable()
class MajorCommentDto {
  @JsonKey(name: '_id')
  final String id;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isDeleted;
  final List<String> source;
  final String perspective;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final String? nickname;
  final String? imageUrl;
  final bool isLiked;

  MajorCommentDto(
    this.id,
    this.content,
    this.createdAt,
    this.likeCount,
    this.isDeleted,
    this.source,
    this.perspective,
    this.leftLikeCount,
    this.centerLikeCount,
    this.rightLikeCount,
    this.nickname,
    this.imageUrl,
    this.isLiked,
  );

  factory MajorCommentDto.fromJson(Map<String, dynamic> json) =>
      _$MajorCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MajorCommentDtoToJson(this);
}
