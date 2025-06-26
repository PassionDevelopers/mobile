import '../repositoryInterfaces/manage_media_subscription_interface.dart';

class ManageMediaSubscriptionUseCase {
  final ManageMediaSubscriptionRepository _repository;

  ManageMediaSubscriptionUseCase(this._repository);

  Future<void> subscribeSouceBySouceId(String sourceId) async {
    await _repository.subscribeSourceBySourceId(sourceId);
  }

  Future<void> unsubscribeSourceBySourceId(String sourceId) async {
    await _repository.unsubscribeSourceBySourceId(sourceId);
  }
}