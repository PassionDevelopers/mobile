

import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/entities/topic/topics.dart';
import 'package:could_be/domain/repositoryInterfaces/topic/topics_interface.dart';

class SearchTopicsUseCase {
  final TopicsRepository _repository;

  SearchTopicsUseCase(this._repository);

  Future<Topics> searchTopics(String query) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.searchTopics,
      parameters: {
        AnalyticsParameterKeys.searchTerm: query,
        AnalyticsParameterKeys.searchType: AnalyticsParameterKeys.searchTypeTopic,
      },
    );
    return await _repository.searchTopics(query);
  }
}