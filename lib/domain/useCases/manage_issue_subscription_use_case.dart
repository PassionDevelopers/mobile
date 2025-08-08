import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_subscription_interface.dart';

class ManageIssueSubscriptionUseCase {
  final ManageIssueSubscriptionRepository _manageIssueSubscriptionRepository;

  ManageIssueSubscriptionUseCase(this._manageIssueSubscriptionRepository);

  Future<void> subscribeIssueByIssueId(String issueId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageIssueSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.subscribe,
        AnalyticsParameterKeys.issueId: issueId,
      },
    );
    await _manageIssueSubscriptionRepository.subscribeIssueByIssueId(issueId);
  }

  Future<void> unsubscribeIssueByIssueId(String issueId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageIssueSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.unsubscribe,
        AnalyticsParameterKeys.issueId: issueId,
      },
    );
    await _manageIssueSubscriptionRepository.unsubscribeIssueByIssueId(issueId);
  }

}