import 'package:could_be/data/dto/notifications_dto.dart';
import 'package:could_be/domain/entities/notifications.dart';
import 'package:could_be/domain/repositoryInterfaces/notifications_interface.dart';
import 'package:dio/dio.dart';

class NotificationsRepositoryImpl extends NotificationsRepository{

  final Dio dio;
  NotificationsRepositoryImpl(this.dio);

  @override
  Future<Notifications> fetchNotifications()async{
    final response = await dio.get('/user/notifications/global');
    final notificationsDto = NotificationsDto.fromJson(response.data);

    return notificationsDto.toDomain();
  }

  @override
  void updateNotifications(Notifications notifications)async{
    final notificationsDto = NotificationsDto(
      notifications.commentLikeEnabled,
      notifications.commentReplyEnabled,
      notifications.majorCommentEnabled,
      notifications.issueSubscriptionEnabled,
      notifications.mediaSubscriptionEnabled,
      notifications.topicSubscriptionEnabled,
    );
    await dio.post('/user/notifications/global', data: notificationsDto.toJson());
  }

}