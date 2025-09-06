import 'package:could_be/domain/entities/notifications.dart';
import 'package:could_be/domain/repositoryInterfaces/notifications_interface.dart';

class NotificationsUseCase{
  final NotificationsRepository repository;
  NotificationsUseCase(this.repository);

  Future<Notifications> fetchNotifications() async {
    return await repository.fetchNotifications();
  }

  Future<void> updateNotifications(Notifications notifications) async {
    repository.updateNotifications(notifications);
  }
}