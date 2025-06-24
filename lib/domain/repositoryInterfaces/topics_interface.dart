import '../entities/topics.dart';

abstract class TopicsRepository {

  Future<Topics> fetchSubscribedTopics();

  Future<Topics> fetchAllTopics();

}