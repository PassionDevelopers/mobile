import 'package:could_be/domain/repositoryInterfaces/manage_issue_subscription_interface.dart';

class ManageIssueSubscriptionUseCase {
  final ManageIssueSubscriptionRepository _manageIssueSubscriptionRepository;

  ManageIssueSubscriptionUseCase(this._manageIssueSubscriptionRepository);

  Future<void> subscribeIssueByIssueId(String issueId) async {
    await _manageIssueSubscriptionRepository.subscribeIssueByIssueId(issueId);
  }

  Future<void> unsubscribeIssueByIssueId(String issueId) async {
    await _manageIssueSubscriptionRepository.unsubscribeIssueByIssueId(issueId);
  }

}