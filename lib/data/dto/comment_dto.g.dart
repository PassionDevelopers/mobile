// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) => CommentDto(
  id: json['_id'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likeCount: (json['likeCount'] as num).toInt(),
  isDeleted: json['isDeleted'] as bool,
  source: (json['source'] as List<dynamic>).map((e) => e as String).toList(),
  userId: json['userId'] as String?,
  nickname: json['nickname'] as String?,
  imageUrl: json['imageUrl'] as String?,
  isLiked: json['isLiked'] as bool,
  replies:
      (json['replies'] as List<dynamic>)
          .map((e) => ReplyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CommentDtoToJson(CommentDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'isDeleted': instance.isDeleted,
      'source': instance.source,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'imageUrl': instance.imageUrl,
      'isLiked': instance.isLiked,
      'replies': instance.replies,
    };
