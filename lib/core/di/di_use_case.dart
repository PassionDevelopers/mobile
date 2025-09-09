
import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/fcm_use_case.dart';
import 'package:could_be/domain/useCases/issue/fetch_hot_issues_use_case.dart';
import 'package:could_be/domain/useCases/issue/fetch_issue_query_params_use_case.dart';
import 'package:could_be/domain/useCases/fetch_notice_use_case.dart';
import 'package:could_be/domain/useCases/source/fetch_source_detail_use_case.dart';
import 'package:could_be/domain/useCases/topic/fetch_topic_detail_use_case.dart';
import 'package:could_be/domain/useCases/issue/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/source/manage_source_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/user/manage_user_profile_use_case.dart';
import 'package:could_be/domain/useCases/user/manage_user_status_use_case.dart';
import 'package:could_be/domain/useCases/notifications_use_case.dart';
import 'package:could_be/domain/useCases/onboarding_use_case.dart';
import 'package:could_be/domain/useCases/report_use_case.dart';
import 'package:could_be/domain/useCases/issue/search_issues_use_case.dart';
import 'package:could_be/domain/useCases/topic/search_topics_use_case.dart';
import 'package:could_be/domain/useCases/track_user_activity_use_case.dart';
import '../../domain/useCases/fetch_articles_use_case.dart';
import '../../domain/useCases/issue/fetch_issues_use_case.dart';
import '../../domain/useCases/source/fetch_sources_use_case.dart';
import '../../domain/useCases/topic/fetch_topics_use_case.dart';
import '../../domain/useCases/issue/fetch_whole_issue_use_case.dart';
import '../../domain/useCases/issue/manage_issue_subscription_use_case.dart';
import '../../domain/useCases/source/manage_media_subscription_use_case.dart';
import '../../domain/useCases/topic/manage_topic_subscription_use_case.dart';
import '../../domain/useCases/submit_feedback_use_case.dart';
import '../../domain/useCases/whole_bias_score_use_case.dart';
import 'di_setup.dart';
Future<void> diUseCaseSetup() async {
  //bias test
  getIt.registerSingleton(OnboardingUseCase(getIt()));

  //notice
  getIt.registerSingleton(FetchNoticeUseCase(getIt()));

  //issue
  getIt.registerSingleton(FetchIssuesUseCase(getIt()));
  getIt.registerSingleton(FetchIssueDetailUseCase(getIt()));
  getIt.registerSingleton(ManageIssueSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchIssueQueryParamsUseCase(getIt()));
  getIt.registerSingleton(SearchIssuesUseCase(getIt()));
  getIt.registerSingleton(FetchHotIssuesUseCase(getIt()));

  //user
  getIt.registerSingleton(ManageUserStatusUseCase(getIt()));
  getIt.registerSingleton(ManageIssueEvaluationUseCase(getIt()));
  getIt.registerSingleton(ManageUserProfileUseCase(getIt()));
  getIt.registerSingleton(WholeBiasScoreUseCase(getIt()));
  getIt.registerSingleton(TrackUserActivityUseCase(getIt()));
  getIt.registerSingleton(FcmUseCase(getIt()));
  getIt.registerSingleton(NotificationsUseCase(getIt()));
  
  //community
  getIt.registerSingleton(CommentUseCase(getIt()));
  getIt.registerSingleton(ReportUseCase(reportRepository: getIt()));

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
  getIt.registerSingleton(ManageSourceEvaluationUseCase(getIt()));

  //feedback
  getIt.registerSingleton(SubmitFeedbackUseCase(getIt()));
}