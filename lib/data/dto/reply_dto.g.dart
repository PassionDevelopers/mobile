// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyDto _$ReplyDtoFromJson(Map<String, dynamic> json) => ReplyDto(
  json['_id'] as String,
  json['userId'] as String?,
  json['content'] as String,
  DateTime.parse(json['createdAt'] as String),
  (json['likeCount'] as num).toInt(),
  json['isDeleted'] as bool,
  (json['source'] as List<dynamic>).map((e) => e as String).toList(),
  json['nickname'] as String?,
  json['imageUrl'] as String?,
  json['isLiked'] as bool,
);

Map<String, dynamic> _$ReplyDtoToJson(ReplyDto instance) => <String, dynamic>{
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
};
