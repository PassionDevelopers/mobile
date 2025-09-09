// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'major_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MajorCommentDto _$MajorCommentDtoFromJson(Map<String, dynamic> json) =>
    MajorCommentDto(
      json['_id'] as String,
      json['content'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['isDeleted'] as bool,
      (json['source'] as List<dynamic>).map((e) => e as String).toList(),
      json['perspective'] as String,
      (json['leftLikeCount'] as num).toInt(),
      (json['centerLikeCount'] as num).toInt(),
      (json['rightLikeCount'] as num).toInt(),
      json['nickname'] as String?,
      json['imageUrl'] as String?,
      json['isLiked'] as bool,
      json['userId'] as String?,
    );

Map<String, dynamic> _$MajorCommentDtoToJson(MajorCommentDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'source': instance.source,
      'perspective': instance.perspective,
      'leftLikeCount': instance.leftLikeCount,
      'centerLikeCount': instance.centerLikeCount,
      'rightLikeCount': instance.rightLikeCount,
      'nickname': instance.nickname,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'isLiked': instance.isLiked,
    };
