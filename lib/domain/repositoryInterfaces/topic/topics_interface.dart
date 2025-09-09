import '../../entities/topic/topics.dart';

abstract class TopicsRepository {

  Future<Topics> searchTopics(String query);

  Future<Topics> fetchSubscribedTopics();

  Future<Topics> fetchSepecificCategoryTopics(String category);

}