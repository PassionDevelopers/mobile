// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDto _$TopicDtoFromJson(Map<String, dynamic> json) => TopicDto(
  id: json['_id'] as String,
  name: json['name'] as String,
  categories:
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
  issuesCount: (json['issuesCount'] as num).toInt(),
  isSubscribed: json['isSubscribed'] as bool,
);

Map<String, dynamic> _$TopicDtoToJson(TopicDto instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'categories': instance.categories,
  'issuesCount': instance.issuesCount,
  'isSubscribed': instance.isSubscribed,
};
