import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';

class ManageTopicSubscriptionUseCase {
  final ManageTopicSubscriptionRepository _manageTopicSubscriptionRepository;

  ManageTopicSubscriptionUseCase(this._manageTopicSubscriptionRepository);

  Future<void> subscribeTopicByTopicId(String topicId) async {
    getIt<Amplitude>().track(AmplitudeEvents.subscribeTopicByTopicId);
    await _manageTopicSubscriptionRepository.subscribeTopicByTopicId(topicId);
  }

  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    getIt<Amplitude>().track(AmplitudeEvents.unsubscribeTopicByTopicId);
    await _manageTopicSubscriptionRepository.unsubscribeTopicByTopicId(topicId);
  }
}