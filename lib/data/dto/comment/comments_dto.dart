import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/data/dto/comment/comment_dto.dart';
import 'package:could_be/domain/entities/comment/comments.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments_dto.g.dart';

@JsonSerializable()
class CommentsDto {
  final String perspective;
  final List<CommentDto> comments;
  final bool hasMore;
  final String? lastCommentId;
  final int commentsCount;

  CommentsDto(
    this.perspective,
    this.comments,
    this.hasMore,
    this.lastCommentId,
    this.commentsCount,
  );

  factory CommentsDto.fromJson(Map<String, dynamic> json) =>
      _$CommentsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsDtoToJson(this);
}

extension CommentsDtx on CommentsDto {
  Comments toDomain() {
    final bias = getBiasFromString(perspective);
    return Comments(
      perspective: bias,
      comments: comments.map((e) => e.toDomain(bias: bias)).toList(),
      hasMore: hasMore,
      lastCommentId: lastCommentId,
      commentsCount: commentsCount,
    );
  }
}
