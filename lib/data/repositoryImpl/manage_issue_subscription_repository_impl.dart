import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/issue/manage_issue_subscription_interface.dart';

class ManageIssueSubscriptionRepositoryImpl
    implements ManageIssueSubscriptionRepository {
  final Dio dio;

  ManageIssueSubscriptionRepositoryImpl(this.dio);

  @override
  Future<void> subscribeIssueByIssueId(String issueId) async {
    await dio.post(
      '${ApiVersions.v1}/issues/$issueId/subscribe',
    );
  }

  @override
  Future<void> unsubscribeIssueByIssueId(String issueId) async {
    await dio.delete(
      '${ApiVersions.v1}/issues/$issueId/subscribe',
    );
  }
}