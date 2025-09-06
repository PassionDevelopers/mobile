import 'package:could_be/domain/entities/notifications.dart';

class NotificationsSettingState{
  final bool isEnabled;
  final bool isLoading;
  final Notifications notifications;

  NotificationsSettingState({
    this.isEnabled = false,
    this.isLoading = false,
    required this.notifications
  });

  NotificationsSettingState copyWith({
    bool? isLoading,
    bool? isEnabled,
    Notifications? notifications,
  }) {
    return NotificationsSettingState(
      isLoading: isLoading ?? this.isLoading,
      isEnabled: isEnabled ?? this.isEnabled,
      notifications: notifications ?? this.notifications,
    );
  }
}