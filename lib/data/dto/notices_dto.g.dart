// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticesDto _$NoticesDtoFromJson(Map<String, dynamic> json) => NoticesDto(
  (json['notices'] as List<dynamic>)
      .map((e) => NoticeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['hasMore'] as bool,
  json['lastNoticeId'] as String?,
);

Map<String, dynamic> _$NoticesDtoToJson(NoticesDto instance) =>
    <String, dynamic>{
      'notices': instance.notices,
      'hasMore': instance.hasMore,
      'lastNoticeId': instance.lastNoticeId,
    };
