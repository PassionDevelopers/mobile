import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';

class ManageTopicSubscriptionUseCase {
  final ManageTopicSubscriptionRepository _manageTopicSubscriptionRepository;

  ManageTopicSubscriptionUseCase(this._manageTopicSubscriptionRepository);

  Future<void> subscribeTopicByTopicId(String topicId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageTopicSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.subscribe,
        AnalyticsParameterKeys.topicId: topicId,
      },
    );
    await _manageTopicSubscriptionRepository.subscribeTopicByTopicId(topicId);
  }

  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageTopicSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.unsubscribe,
        AnalyticsParameterKeys.topicId: topicId,
      },
    );
    await _manageTopicSubscriptionRepository.unsubscribeTopicByTopicId(topicId);
  }
}