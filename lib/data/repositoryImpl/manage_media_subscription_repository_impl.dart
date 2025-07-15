import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/manage_media_subscription_interface.dart';

class ManageMediaSubscriptionRepositoryImpl
    implements ManageMediaSubscriptionRepository {
  final Dio dio;

  ManageMediaSubscriptionRepositoryImpl(this.dio);

  @override
  Future<void> subscribeSourceBySourceId(String sourceId)async{
    final response = await dio.post(
      '${ApiVersions.v1}/media/$sourceId/subscribe',
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception('Failed to subscribe source: $sourceId');
    }
  }

  @override
  Future<void> unsubscribeSourceBySourceId(String sourceId) async {
    final response = await dio.delete(
      '${ApiVersions.v1}/media/$sourceId/subscribe',
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception('Failed to unsubscribe source: $sourceId');
    }
  }
}