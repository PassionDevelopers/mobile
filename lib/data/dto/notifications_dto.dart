import 'package:could_be/domain/entities/notifications.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_dto.g.dart';

@JsonSerializable()
class NotificationsDto {
  final bool commentLikeEnabled;
  final bool commentReplyEnabled;
  final bool majorCommentEnabled;
  final bool issueSubscriptionEnabled;
  final bool mediaSubscriptionEnabled;
  final bool topicSubscriptionEnabled;

  NotificationsDto(
    this.commentLikeEnabled,
    this.commentReplyEnabled,
    this.majorCommentEnabled,
    this.issueSubscriptionEnabled,
    this.mediaSubscriptionEnabled,
    this.topicSubscriptionEnabled,
  );

  factory NotificationsDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsDtoToJson(this);
}

extension NotificationsDtx on NotificationsDto {
  Notifications toDomain() {
    return Notifications(
      commentLikeEnabled: commentLikeEnabled,
      commentReplyEnabled: commentReplyEnabled,
      majorCommentEnabled: majorCommentEnabled,
      issueSubscriptionEnabled: issueSubscriptionEnabled,
      mediaSubscriptionEnabled: mediaSubscriptionEnabled,
      topicSubscriptionEnabled: topicSubscriptionEnabled,
    );
  }
}
