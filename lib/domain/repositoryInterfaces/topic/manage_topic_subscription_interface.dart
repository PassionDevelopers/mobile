abstract class ManageTopicSubscriptionRepository {
  Future<void> subscribeTopicByTopicId(String topicId);
  Future<void> unsubscribeTopicByTopicId(String topicId);
}