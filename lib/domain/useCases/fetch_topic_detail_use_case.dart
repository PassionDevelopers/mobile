import '../entities/topic_detail.dart';
import '../repositoryInterfaces/topic_detail_interface.dart';

class FetchTopicDetailUseCase {
  final TopicDetailRepository _topicDetailRepository;

  FetchTopicDetailUseCase(this._topicDetailRepository);

  Future<TopicDetail> fetchTopicDetailById(String topicId) async {
    return await _topicDetailRepository.fetchTopicDetailById(topicId);
  }
}