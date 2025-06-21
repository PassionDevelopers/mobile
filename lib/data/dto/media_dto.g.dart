// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDTO _$MediaDTOFromJson(Map<String, dynamic> json) => MediaDTO(
  media:
      (json['media'] as List<dynamic>)
          .map((e) => MediumDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasMore: json['hasMore'] as bool,
  lastMediaId: json['lastMediaId'] as String,
);

Map<String, dynamic> _$MediaDTOToJson(MediaDTO instance) => <String, dynamic>{
  'media': instance.media,
  'hasMore': instance.hasMore,
  'lastMediaId': instance.lastMediaId,
};
