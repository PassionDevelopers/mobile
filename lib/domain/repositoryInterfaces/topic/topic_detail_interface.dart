import '../../entities/topic/topic_detail.dart';

abstract class TopicDetailRepository {
  Future<TopicDetail> fetchTopicDetailById(String id);
}