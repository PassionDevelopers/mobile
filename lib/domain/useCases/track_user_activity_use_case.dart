import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/repositoryInterfaces/track_user_activity_interface.dart';

class TrackUserActivityUseCase {
  // final UserActivityRepository _repository;

  final TrackUserActivityRepository repository;
  TrackUserActivityUseCase(this.repository);

  Future<void> postDasiScore({required String issueId, required double score}) {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.postDasiScore,
      parameters: {
        AnalyticsParameterKeys.issueId: issueId,
      },
    );
    return repository.postDasiScore(issueId: issueId, score: score);
  }

  Future<void> postUserWatchedArticles(){
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.trackUserActivity,
      parameters: {
        AnalyticsParameterKeys.action: 'post_watched_articles',
      },
    );
    return repository.postUserWatchedArticles();
  }

  Future<void> saveUserWatchedArticle({required String articleId,}) {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.trackUserActivity,
      parameters: {
        AnalyticsParameterKeys.action: 'save_watched_article',
        AnalyticsParameterKeys.articleId: articleId,
      },
    );
    return repository.saveUserWatchedArticle(articleId: articleId);
  }

}
