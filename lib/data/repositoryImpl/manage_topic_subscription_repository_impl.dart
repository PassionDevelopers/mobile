import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/manage_topic_subscription_interface.dart';

class ManageTopicSubscriptionRepositoryImpl
    implements ManageTopicSubscriptionRepository {
  final Dio dio;

  ManageTopicSubscriptionRepositoryImpl(this.dio);

  @override
  Future<void> subscribeTopicByTopicId(String topicId) async {
    final response = await dio.post(
        '${ApiVersions.v1}/topics/subscribe/$topicId',
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception('Failed to subscribe topic: $topicId');
    }
  }

  @override
  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    final response = await dio.delete(
        '${ApiVersions.v1}/topics/subscribe/$topicId',

    );
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception('Failed to unsubscribe topic: $topicId');
    }
  }
}