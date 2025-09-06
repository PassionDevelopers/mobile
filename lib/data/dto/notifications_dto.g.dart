// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsDto _$NotificationsDtoFromJson(Map<String, dynamic> json) =>
    NotificationsDto(
      json['commentLikeEnabled'] as bool,
      json['commentReplyEnabled'] as bool,
      json['majorCommentEnabled'] as bool,
      json['issueSubscriptionEnabled'] as bool,
      json['mediaSubscriptionEnabled'] as bool,
      json['topicSubscriptionEnabled'] as bool,
    );

Map<String, dynamic> _$NotificationsDtoToJson(NotificationsDto instance) =>
    <String, dynamic>{
      'commentLikeEnabled': instance.commentLikeEnabled,
      'commentReplyEnabled': instance.commentReplyEnabled,
      'majorCommentEnabled': instance.majorCommentEnabled,
      'issueSubscriptionEnabled': instance.issueSubscriptionEnabled,
      'mediaSubscriptionEnabled': instance.mediaSubscriptionEnabled,
      'topicSubscriptionEnabled': instance.topicSubscriptionEnabled,
    };
