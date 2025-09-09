import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';
import '../../../domain/repositoryInterfaces/source/manage_media_subscription_interface.dart';

class ManageSourceSubscriptionRepositoryImpl
    implements ManageMediaSubscriptionRepository {
  final Dio dio;

  ManageSourceSubscriptionRepositoryImpl(this.dio);

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