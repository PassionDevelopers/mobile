abstract class TrackUserActivityRepository{
  Future<void> postUserWatchedArticles({required List<String> articleIds});
}