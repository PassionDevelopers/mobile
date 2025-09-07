
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/data/repositoryImpl/comment_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/hot_issues_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/issue_query_params_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_fcm_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_issue_evaluation_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_source_evaluation_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_topic_subscription_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_user_profile_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_user_status_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/notice_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/notifications_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/onboarding_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/report_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/source_detail_impl.dart';
import 'package:could_be/data/repositoryImpl/topic_detail_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/track_user_activity_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/whole_bias_score_repository_impl.dart';
import 'package:could_be/domain/repositoryInterfaces/article/articles_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/comment_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/hot_issues_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issue_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issue_query_params_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issues_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_fcm_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/manage_issue_evaluation_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/manage_issue_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_media_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/onboarding_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/user/manage_user_profile_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/user/manage_user_status_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/source/mange_source_evalutaion_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/notice_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/notifications_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/report_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/source/source_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topic_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topics_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/logging/track_user_activity_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_bias_score_interface.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositoryImpl/articles_repository_impl.dart';
import '../../data/repositoryImpl/feedback_repository_impl.dart';
import '../../data/repositoryImpl/issue_detail_repository_impl.dart';
import '../../data/repositoryImpl/issues_repository_impl.dart';
import '../../data/repositoryImpl/manage_issue_subscription_repository_impl.dart';
import '../../data/repositoryImpl/manage_media_subscription_repository_impl.dart';
import '../../data/repositoryImpl/sources_repository_impl.dart';
import '../../data/repositoryImpl/topics_repository_impl.dart';
import '../../domain/repositoryInterfaces/feedback_interface.dart';
import '../../domain/repositoryInterfaces/source/sources_interface.dart';
import 'di_setup.dart';

Future<void> diRepoSetup()async {
  //bias test
  getIt.registerSingleton<OnboardingRepository>(
    OnboardingRepositoryImpl(getIt<Dio>()),
  );

  //notice
  getIt.registerSingleton<NoticeRepository>(
    NoticeRepositoryImpl(getIt<Dio>()),
  );

  //article
  getIt.registerSingleton<ArticlesRepository>(
    ArticlesRepositoryImpl(getIt<Dio>()),
  );

  //issue
  getIt.registerSingleton<IssueDetailRepository>(
    IssueDetailRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<IssueQueryParamsRepository>(
    IssueQueryParamsRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<IssuesRepository>(IssuesRepositoryImpl(getIt<Dio>()));
  getIt.registerSingleton<ManageIssueSubscriptionRepository>(
    ManageIssueSubscriptionRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<HotIssuesRepository>(
    HotIssuesRepositoryImpl(getIt<Dio>()),
  );

  //user
  getIt.registerSingleton<ManageIssueEvaluationRepository>(
    ManageIssueEvaluationRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageUserStatusRepository>(
    ManageUserStatusRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageUserProfileRepository>(
    ManageUserProfileRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<WholeBiasScoreRepository>(
    WholeBiasScoreRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<TrackUserActivityRepository>(
    TrackUserActivityRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageFcmRepository>(
    ManageFcmRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<NotificationsRepository>(
    NotificationsRepositoryImpl(getIt<Dio>()),
  );

  //community
  getIt.registerSingleton<CommentRepository>(CommentRepositoryImpl(getIt<Dio>()));
  getIt.registerSingleton<ReportRepository>(
    ReportRepositoryImpl(getIt<Dio>()),
  );

  //source
  getIt.registerSingleton<ManageMediaSubscriptionRepository>(
    ManageMediaSubscriptionRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<SourceDetailRepository>(
    SourceDetailRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<SourcesRepository>(
    SourcesRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageSourceEvaluationRepository>(
    ManageSourceEvaluationRepositoryImpl(getIt<Dio>()),
  );

  //topic
  getIt.registerSingleton<ManageTopicSubscriptionRepository>(
    ManageTopicSubscriptionRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<TopicsRepository>(TopicsRepositoryImpl(getIt<Dio>()));
  getIt.registerSingleton<TopicDetailRepository>(
    TopicDetailRepositoryImpl(getIt<Dio>()),
  );

  //feedback
  getIt.registerSingleton<FeedbackInterface>(
    FeedbackRepositoryImpl(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
  );
}