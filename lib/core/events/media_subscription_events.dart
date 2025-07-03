import 'dart:async';

class MediaSubscriptionEvents {
  static final StreamController<String> _subscriptionController = 
      StreamController<String>.broadcast();
  static final StreamController<String> _unsubscriptionController = 
      StreamController<String>.broadcast();

  static Stream<String> get subscriptionStream => _subscriptionController.stream;
  static Stream<String> get unsubscriptionStream => _unsubscriptionController.stream;

  static void notifyMediaSubscribed(String sourceId) {
    _subscriptionController.add(sourceId);
  }

  static void notifyMediaUnsubscribed(String sourceId) {
    _unsubscriptionController.add(sourceId);
  }
}