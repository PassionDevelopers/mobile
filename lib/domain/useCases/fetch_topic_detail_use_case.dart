
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import '../entities/topic_detail.dart';
import '../repositoryInterfaces/topic_detail_interface.dart';

class FetchTopicDetailUseCase {
  final TopicDetailRepository _topicDetailRepository;

  FetchTopicDetailUseCase(this._topicDetailRepository);

  Future<TopicDetail> fetchTopicDetailById(String topicId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchTopicDetail,
      parameters: {
        AnalyticsParameterKeys.topicId: topicId,
      },
    );
    return await _topicDetailRepository.fetchTopicDetailById(topicId);
  }
}