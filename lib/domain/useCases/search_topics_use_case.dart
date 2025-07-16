

import 'package:could_be/domain/entities/topics.dart';
import 'package:could_be/domain/repositoryInterfaces/topics_interface.dart';

class SearchTopicsUseCase {
  final TopicsRepository _repository;

  SearchTopicsUseCase(this._repository);

  Future<Topics> searchTopics(String query) async {
    return await _repository.searchTopics(query);
  }
}