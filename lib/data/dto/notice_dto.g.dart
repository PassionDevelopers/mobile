// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeDto _$NoticeDtoFromJson(Map<String, dynamic> json) => NoticeDto(
  id: json['_id'] as String,
  title: json['title'] as String,
  content: json['content'] as String?,
  isImportant: json['isImportant'] as bool,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$NoticeDtoToJson(NoticeDto instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'isImportant': instance.isImportant,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
