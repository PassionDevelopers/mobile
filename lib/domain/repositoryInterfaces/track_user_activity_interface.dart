abstract class TrackUserActivityRepository{

  Future<void> saveUserWatchedArticle({required String articleId});

  Future<void> postUserWatchedArticles();

  Future<void> postDasiScore({required String issueId, required double score});
}