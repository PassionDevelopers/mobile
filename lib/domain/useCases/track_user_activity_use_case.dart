import 'package:could_be/domain/repositoryInterfaces/track_user_activity_interface.dart';

class TrackUserActivityUseCase {
  // final UserActivityRepository _repository;

  final TrackUserActivityRepository repository;
  TrackUserActivityUseCase(this.repository);

  Future<void> postDasiScore({required String issueId, required double score}) {
    return repository.postDasiScore(issueId: issueId, score: score);
  }

  Future<void> postUserWatchedArticles(){
    return repository.postUserWatchedArticles();
  }

  Future<void> saveUserWatchedArticle({required String articleId,}) {
    return repository.saveUserWatchedArticle(articleId: articleId);
  }

}
