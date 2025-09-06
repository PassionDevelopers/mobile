import 'dart:async';

import 'package:could_be/core/permission/permission_management.dart';
import 'package:could_be/domain/entities/notifications.dart';
import 'package:could_be/domain/useCases/notifications_use_case.dart';
import 'package:could_be/presentation/setting/notifications_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum NotificationType {
  isEnabled,
  commentLike,
  commentReply,
  majorComment,
  issueSubscription,
  mediaSubscription,
  topicSubscription,
}

class NotificationSettingViewModel with ChangeNotifier {

  final NotificationsUseCase notificationsUseCase;
  NotificationSettingViewModel({required this.notificationsUseCase}){
    fetchNotificationSettings();
    pollingPermissionStatus();
  }

  NotificationsSettingState _state = NotificationsSettingState(
    notifications: Notifications(
      commentLikeEnabled: false,
      commentReplyEnabled: false,
      majorCommentEnabled: false,
      issueSubscriptionEnabled: false,
      mediaSubscriptionEnabled: false,
      topicSubscriptionEnabled: false,
    ),
  );

  NotificationsSettingState get state => _state;
  late final Timer _pollingTimer;

  void pollingPermissionStatus() async {

    _pollingTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      final currentStatus = await checkFCMPermissionStatus();
      if (currentStatus != state.isEnabled) {
        _state = state.copyWith(isEnabled: currentStatus);
        notifyListeners();
      }
    });
  }

  void fetchNotificationSettings() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    bool isEnabled = await checkFCMPermissionStatus();

    final notifications = await notificationsUseCase.fetchNotifications();
    _state = state.copyWith(
      isEnabled: isEnabled,
      isLoading: false,
      notifications: notifications
    );
    notifyListeners();
  }

  void updateNotificationSetting(NotificationType type) async {
    switch(type) {
      case NotificationType.isEnabled:
        requestFCMPermission(false);
      case NotificationType.commentLike:
        _state = state.copyWith(notifications: state.notifications.copyWith(commentLikeEnabled: !state.notifications.commentLikeEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
      case NotificationType.commentReply:
        _state = state.copyWith(notifications: state.notifications.copyWith(commentReplyEnabled: !state.notifications.commentReplyEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
      case NotificationType.majorComment:
        _state = state.copyWith(notifications: state.notifications.copyWith(majorCommentEnabled: !state.notifications.majorCommentEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
      case NotificationType.issueSubscription:
        _state = state.copyWith(notifications: state.notifications.copyWith(issueSubscriptionEnabled: !state.notifications.issueSubscriptionEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
      case NotificationType.mediaSubscription:
        _state = state.copyWith(notifications: state.notifications.copyWith(mediaSubscriptionEnabled: !state.notifications.mediaSubscriptionEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
      case NotificationType.topicSubscription:
        _state = state.copyWith(notifications: state.notifications.copyWith(topicSubscriptionEnabled: !state.notifications.topicSubscriptionEnabled));
        await notificationsUseCase.updateNotifications(state.notifications);
    }
    notifyListeners();
  }


  @override
  void dispose() {
    super.dispose();
    _pollingTimer.cancel();
  }

}