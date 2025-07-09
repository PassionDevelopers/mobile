import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../repositoryInterfaces/manage_media_subscription_interface.dart';

class ManageMediaSubscriptionUseCase {
  final ManageMediaSubscriptionRepository _repository;

  ManageMediaSubscriptionUseCase(this._repository);

  Future<void> subscribeSouceBySouceId(String sourceId) async {
    getIt<Amplitude>().track(AmplitudeEvents.subscribeSourceBySourceId);
    await _repository.subscribeSourceBySourceId(sourceId);
  }

  Future<void> unsubscribeSourceBySourceId(String sourceId) async {
    getIt<Amplitude>().track(AmplitudeEvents.unsubscribeSourceBySourceId);
    await _repository.unsubscribeSourceBySourceId(sourceId);
  }
}