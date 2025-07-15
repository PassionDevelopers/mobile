
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/data/repositoryImpl/issue_query_params_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_issue_evaluation_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_topic_subscription_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_user_profile_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_user_status_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/media_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/source_detail_impl.dart';
import 'package:could_be/data/repositoryImpl/topic_detail_repository_impl.dart';
import 'package:could_be/domain/repositoryInterfaces/articles_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue_query_params_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issues_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_evaluation_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_media_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_status_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/source_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topic_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topics_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/user_bias_interface.dart';
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
import '../../data/repositoryImpl/user_bias_repository_impl.dart';
import '../../domain/repositoryInterfaces/feedback_interface.dart';
import '../../domain/repositoryInterfaces/issue_detail_interface.dart';
import '../../domain/repositoryInterfaces/media_interface.dart';
import '../../domain/repositoryInterfaces/sources_interface.dart';
import 'di_setup.dart';

Future<void> diRepoSetup()async {
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

  //user
  getIt.registerSingleton<ManageIssueEvaluationRepository>(
    ManageIssueEvaluationRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageUserStatusRepository>(
    ManageUserStatusRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<UserBiasRepository>(
    UserBiasRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ManageUserProfileRepository>(
    ManageUserProfileRepositoryImpl(getIt<Dio>()),
  );

  //source
  getIt.registerSingleton<ManageMediaSubscriptionRepository>(
    ManageMediaSubscriptionRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<MediaRepository>(MediaRepositoryImpl(getIt<Dio>()));
  getIt.registerSingleton<SourceDetailRepository>(
    SourceDetailRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<SourcesRepository>(
    SourcesRepositoryImpl(getIt<Dio>()),
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