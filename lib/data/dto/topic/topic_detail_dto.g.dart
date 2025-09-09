// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDetailDto _$TopicDetailDtoFromJson(Map<String, dynamic> json) =>
    TopicDetailDto(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      recentIssues: IssuesDTO.fromJson(
        json['recent_issues'] as Map<String, dynamic>,
      ),
      isSubscribed: json['is_subscribed'] as bool,
      totalIssuesCount: (json['total_issues_count'] as num).toInt(),
      subscribersCount: (json['subscribers_count'] as num).toInt(),
      notificationEnabled: json['notification_enabled'] as bool,
    );

Map<String, dynamic> _$TopicDetailDtoToJson(TopicDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'recent_issues': instance.recentIssues,
      'is_subscribed': instance.isSubscribed,
      'total_issues_count': instance.totalIssuesCount,
      'subscribers_count': instance.subscribersCount,
      'notification_enabled': instance.notificationEnabled,
    };
