import 'package:could_be/domain/repositoryInterfaces/track_user_activity_interface.dart';

class TrackUserActivityUseCase {
  // final UserActivityRepository _repository;

  final TrackUserActivityRepository _repository;
  TrackUserActivityUseCase({
    required TrackUserActivityRepository repository,
  }) : _repository = repository;

  Future<void> reportUserWatchedArticles({required List<String> articleIds}){
    return _repository.postUserWatchedArticles(articleIds: articleIds);
  }

}
