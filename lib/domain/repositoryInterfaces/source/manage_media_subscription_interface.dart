abstract class ManageMediaSubscriptionRepository {

  Future<void> subscribeSourceBySourceId(String sourceId);
  Future<void> unsubscribeSourceBySourceId(String sourceId);


}