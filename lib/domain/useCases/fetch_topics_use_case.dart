import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/entities/topics.dart';

import '../repositoryInterfaces/topics_interface.dart';

class FetchTopicsUseCase {
  final TopicsRepository _topicRepository;

  FetchTopicsUseCase(this._topicRepository);

  Future<Topics> fetchSubscribedTopics() async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSubscribedTopics);
    return await _topicRepository.fetchSubscribedTopics();
  }

  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSpecificCategoryTopics);
    return await _topicRepository.fetchSepecificCategoryTopics(category);
  }
}