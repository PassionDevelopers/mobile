import 'package:could_be/domain/entities/topics.dart';

import '../repositoryInterfaces/topics_interface.dart';

class FetchTopicsUseCase {
  final TopicsRepository _topicRepository;

  FetchTopicsUseCase(this._topicRepository);

  Future<Topics> fetchSubscribedTopics() async {
    return await _topicRepository.fetchSubscribedTopics();
  }

  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    return await _topicRepository.fetchSepecificCategoryTopics(category);
  }
}