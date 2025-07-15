// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicsDto _$TopicsDtoFromJson(Map<String, dynamic> json) => TopicsDto(
  topics:
      (json['topics'] as List<dynamic>)
          .map((e) => TopicDto.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasMore: json['hasMore'] as bool,
  lastTopicId: json['lastTopicId'] as String?,
);

Map<String, dynamic> _$TopicsDtoToJson(TopicsDto instance) => <String, dynamic>{
  'topics': instance.topics,
  'hasMore': instance.hasMore,
  'lastTopicId': instance.lastTopicId,
};
