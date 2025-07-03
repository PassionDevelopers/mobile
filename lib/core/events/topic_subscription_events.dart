import 'dart:async';

class TopicSubscriptionEvents {
  static final StreamController<String> _subscriptionController = 
      StreamController<String>.broadcast();
  static final StreamController<String> _unsubscriptionController = 
      StreamController<String>.broadcast();

  static Stream<String> get subscriptionStream => _subscriptionController.stream;
  static Stream<String> get unsubscriptionStream => _unsubscriptionController.stream;

  static void notifyTopicSubscribed(String topicId) {
    _subscriptionController.add(topicId);
  }

  static void notifyTopicUnsubscribed(String topicId) {
    _unsubscriptionController.add(topicId);
  }
}