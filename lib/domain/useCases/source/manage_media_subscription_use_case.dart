import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';

import '../../repositoryInterfaces/source/manage_media_subscription_interface.dart';

class ManageMediaSubscriptionUseCase {
  final ManageMediaSubscriptionRepository _repository;

  ManageMediaSubscriptionUseCase(this._repository);

  Future<void> subscribeSouceBySouceId(String sourceId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageMediaSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.subscribe,
        AnalyticsParameterKeys.sourceId: sourceId,
      },
    );
    await _repository.subscribeSourceBySourceId(sourceId);
  }

  Future<void> unsubscribeSourceBySourceId(String sourceId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageMediaSubscription,
      parameters: {
        AnalyticsParameterKeys.action: AnalyticsEventNames.unsubscribe,
        AnalyticsParameterKeys.sourceId: sourceId,
      },
    );
    await _repository.unsubscribeSourceBySourceId(sourceId);
  }
}