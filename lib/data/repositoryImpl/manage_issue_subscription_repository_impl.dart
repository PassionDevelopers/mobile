import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/manage_issue_subscription_interface.dart';

class ManageIssueSubscriptionRepositoryImpl
    implements ManageIssueSubscriptionRepository {
  final Dio dio;

  ManageIssueSubscriptionRepositoryImpl(this.dio);

  @override
  Future<void> subscribeIssueByIssueId(String issueId) async {
    await dio.post(
      '/issues/$issueId/subscribe',
    );
  }

  @override
  Future<void> unsubscribeIssueByIssueId(String issueId) async {
    await dio.delete(
      '/issues/$issueId/subscribe',
    );
  }
}