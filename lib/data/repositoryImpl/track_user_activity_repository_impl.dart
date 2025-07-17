import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/domain/repositoryInterfaces/track_user_activity_interface.dart';
import 'package:dio/dio.dart';

class TrackUserActivityRepositoryImpl implements TrackUserActivityRepository {
  final Dio dio;
  TrackUserActivityRepositoryImpl(this.dio);

  @override
  Future<void> postDasiScore({required String issueId, required double score})async{
    final List<String> postedDasiScores = UserPreferences.getPostedDasiScore() ?? [];
    if (postedDasiScores.contains(issueId)) {
      return; // 이미 같은 점수가 게시된 경우, 중복 게시 방지
    }
    final response = await dio.post(
      '${ApiVersions.v1}/user/dasi-score',
      data: {'score': score},
    );
    if(postedDasiScores.length > 9){
      postedDasiScores.removeAt(0);
    }
    postedDasiScores.add(issueId);
    await UserPreferences.setPostedDasiScore(postedDasiScores);
  }

  @override
  Future<void> postUserWatchedArticles() async {
    final List<String> watchedArticles = UserPreferences.getWatchedArticles() ?? [];
    if(watchedArticles.isEmpty) return; // No articles to post
    final response = await dio.post(
      '${ApiVersions.v1}/user/watched-articles',
      data: {'articleIds': watchedArticles},
    );
    //초기화
    final bool? result = await UserPreferences.setWatchedArticles([]);
  }

  @override
  Future<void> saveUserWatchedArticle({required String articleId}) async {
    final watchedArticles = UserPreferences.getWatchedArticles() ?? [];
    if (!watchedArticles.contains(articleId)) {
      watchedArticles.add(articleId);
    }
    final bool? result = await UserPreferences.setWatchedArticles(watchedArticles);
  }
}