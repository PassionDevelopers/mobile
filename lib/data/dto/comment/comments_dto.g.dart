// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsDto _$CommentsDtoFromJson(Map<String, dynamic> json) => CommentsDto(
  json['perspective'] as String,
  (json['comments'] as List<dynamic>)
      .map((e) => CommentDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['hasMore'] as bool,
  json['lastCommentId'] as String?,
  (json['commentsCount'] as num).toInt(),
);

Map<String, dynamic> _$CommentsDtoToJson(CommentsDto instance) =>
    <String, dynamic>{
      'perspective': instance.perspective,
      'comments': instance.comments,
      'hasMore': instance.hasMore,
      'lastCommentId': instance.lastCommentId,
      'commentsCount': instance.commentsCount,
    };
