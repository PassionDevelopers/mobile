import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/entities/topic/topics.dart';

import '../../repositoryInterfaces/topic/topics_interface.dart';

class FetchTopicsUseCase {
  final TopicsRepository _topicRepository;

  FetchTopicsUseCase(this._topicRepository);

  Future<Topics> fetchSubscribedTopics() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchTopics,
      parameters: {
        AnalyticsParameterKeys.contentType: 'subscribed',
      },
    );
    return await _topicRepository.fetchSubscribedTopics();
  }

  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchTopics,
      parameters: {
        AnalyticsParameterKeys.contentType: 'category',
        'category': category,
      },
    );
    return await _topicRepository.fetchSepecificCategoryTopics(category);
  }
}