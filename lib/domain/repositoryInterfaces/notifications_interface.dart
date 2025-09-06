import 'package:could_be/domain/entities/notifications.dart';

abstract class NotificationsRepository{

  Future<Notifications> fetchNotifications();

  void updateNotifications(Notifications notifications);

}