import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';

class ManageTopicSubscriptionUseCase {
  final ManageTopicSubscriptionRepository _manageTopicSubscriptionRepository;

  ManageTopicSubscriptionUseCase(this._manageTopicSubscriptionRepository);

  Future<void> subscribeTopicByTopicId(String topicId) async {
    await _manageTopicSubscriptionRepository.subscribeTopicByTopicId(topicId);
  }

  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    await _manageTopicSubscriptionRepository.unsubscribeTopicByTopicId(topicId);
  }
}