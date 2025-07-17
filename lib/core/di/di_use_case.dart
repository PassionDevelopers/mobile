import 'package:could_be/domain/useCases/fetch_issue_query_params_use_case.dart';
import 'package:could_be/domain/useCases/fetch_source_detail_use_case.dart';
import 'package:could_be/domain/useCases/fetch_topic_detail_use_case.dart';
import 'package:could_be/domain/useCases/fetch_whole_bias_score_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/domain/useCases/search_issues_use_case.dart';
import 'package:could_be/domain/useCases/search_topics_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';

import '../../domain/useCases/fetch_articles_use_case.dart';
import '../../domain/useCases/fetch_issues_use_case.dart';
import '../../domain/useCases/fetch_sources_use_case.dart';
import '../../domain/useCases/fetch_topics_use_case.dart';
import '../../domain/useCases/fetch_user_bias_user_case.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';
import '../../domain/useCases/manage_issue_subscription_use_case.dart';
import '../../domain/useCases/manage_media_subscription_use_case.dart';
import '../../domain/useCases/manage_topic_subscription_use_case.dart';
import '../../domain/useCases/submit_feedback_use_case.dart';
import 'di_setup.dart';
Future<void> diUseCaseSetup() async {
  //issue
  getIt.registerSingleton(FetchIssuesUseCase(getIt()));
  getIt.registerSingleton(FetchIssueDetailUseCase(getIt()));
  getIt.registerSingleton(ManageIssueSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchIssueQueryParamsUseCase(getIt()));
  getIt.registerSingleton(SearchIssuesUseCase(getIt()));

  //user
  getIt.registerSingleton(FetchUserBiasUseCase(getIt()));
  getIt.registerSingleton(ManageUserStatusUseCase(getIt()));
  getIt.registerSingleton(ManageIssueEvaluationUseCase(getIt()));
  getIt.registerSingleton(ManageUserProfileUseCase(getIt()));
  getIt.registerSingleton(FetchWholeBiasScoreUseCase(getIt()));
  getIt.registerSingleton(TrackUserActivityUseCase(getIt()));

  //articles
  getIt.registerSingleton(FetchArticlesUseCase(getIt()));

  //topic
  getIt.registerSingleton(FetchTopicsUseCase(getIt()));
  getIt.registerSingleton(ManageTopicSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchTopicDetailUseCase(getIt()));
  getIt.registerSingleton(SearchTopicsUseCase(getIt()));

  //source
  getIt.registerSingleton(FetchSourcesUseCase(getIt()));
  getIt.registerSingleton(ManageMediaSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchSourceDetailUseCase(getIt()));

  //feedback
  getIt.registerSingleton(SubmitFeedbackUseCase(getIt()));
}