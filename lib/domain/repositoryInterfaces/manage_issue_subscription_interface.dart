abstract class ManageIssueSubscriptionRepository {

  Future<void> subscribeIssueByIssueId(String issueId);

  Future<void> unsubscribeIssueByIssueId(String issueId);

}