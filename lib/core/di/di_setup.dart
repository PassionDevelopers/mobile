import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/data/repositoryImpl/issue_query_params_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_issue_evaluation_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_topic_subscription_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_user_status_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/token_storage_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/media_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/source_detail_impl.dart';
import 'package:could_be/data/repositoryImpl/topic_detail_repository_impl.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/articles_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issue_query_params_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/issues_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_evaluation_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_media_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_topic_subscription_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_status_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/source_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topic_detail_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/topics_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/user_bias_interface.dart';
import 'package:could_be/domain/useCases/fetch_issue_query_params_use_case.dart';
import 'package:could_be/domain/useCases/fetch_source_detail_use_case.dart';
import 'package:could_be/domain/useCases/fetch_topic_detail_use_case.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_status_use_case.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view_model.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/presentation/media/subscribed_media/subscribed_media_view_model.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/presentation/topic/topic_detail_view/topic_detail_view_model.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/repositoryImpl/articles_repository_impl.dart';
import '../../data/repositoryImpl/issue_detail_repository_impl.dart';
import '../../data/repositoryImpl/issues_repository_impl.dart';
import '../../data/repositoryImpl/manage_issue_subscription_repository_impl.dart';
import '../../data/repositoryImpl/manage_media_subscription_repository_impl.dart';
import '../../data/repositoryImpl/sources_repository_impl.dart';
import '../../data/repositoryImpl/topics_repository_impl.dart';
import '../../data/repositoryImpl/user_bias_repository_impl.dart';
import '../../domain/repositoryInterfaces/issue_detail_interface.dart';
import '../../domain/repositoryInterfaces/media_interface.dart';
import '../../domain/repositoryInterfaces/sources_interface.dart';
import '../../domain/useCases/fetch_articles_use_case.dart';
import '../../domain/useCases/fetch_issues_use_case.dart';
import '../../domain/useCases/fetch_sources_use_case.dart';
import '../../domain/useCases/fetch_topics_use_case.dart';
import '../../domain/useCases/fetch_user_bias_user_case.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';
import '../../domain/useCases/manage_issue_subscription_use_case.dart';
import '../../domain/useCases/manage_media_subscription_use_case.dart';
import '../../domain/useCases/manage_topic_subscription_use_case.dart';
import '../../presentation/issue_detail_feed/issue_detail_view_model.dart';
import '../../presentation/issue_list/issue_type.dart';
import '../../presentation/issue_list/main/issue_list_view_model.dart';
import '../../presentation/media/media_detail/media_detail_view_model.dart';
import '../../presentation/media/whole_media/whole_media_view_model.dart';
import '../../presentation/my_page/main/my_page_view_model.dart';
import '../../presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'api.dart';

final getIt = GetIt.instance;

Future<void> diSetupToken() async {
  getIt.registerSingleton<TokenStorageRepository>(TokenStorageRepositoryImpl());

  getIt.registerSingleton<FirebaseLoginUseCase>(
    FirebaseLoginUseCase(tokenStorageRepository: getIt()),
  );

  getIt.registerSingleton<LoginViewModel>(
    LoginViewModel(firebaseLoginUseCase: getIt()),
  );
}

Future<void> diSetup() async{
  //
  // dio with token interceptor
  //
  getIt.registerSingleton<Dio>(createDio(getIt()));

  //
  // repository
  //

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
  ///////////////////////////////////////////////////////////////////////////

  //
  // useCase
  //

  //issue
  getIt.registerSingleton(FetchIssuesUseCase(getIt()));
  getIt.registerSingleton(FetchIssueDetailUseCase(getIt()));
  getIt.registerSingleton(ManageIssueSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchIssueQueryParamsUseCase(getIt()));

  //user
  getIt.registerSingleton(FetchUserBiasUseCase(getIt()));
  getIt.registerSingleton(ManageUserStatusUseCase(getIt()));
  getIt.registerSingleton(ManageIssueEvaluationUseCase(getIt()));

  //articles
  getIt.registerSingleton(FetchArticlesUseCase(getIt()));

  //topic
  getIt.registerSingleton(FetchTopicsUseCase(getIt()));
  getIt.registerSingleton(ManageTopicSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchTopicDetailUseCase(getIt()));

  //source
  getIt.registerSingleton(FetchSourcesUseCase(getIt()));
  getIt.registerSingleton(ManageMediaSubscriptionUseCase(getIt()));
  getIt.registerSingleton(FetchSourceDetailUseCase(getIt()));
  ///////////////////////////////////////////////////////////////////////////

  //
  // viewModel
  //

  //issue
  getIt.registerFactoryParam<IssueListViewModel, IssueType, String?>(
    (issueType, topicId) => IssueListViewModel(
      fetchIssuesUseCase: getIt(),
      issueType: issueType,
      topicId: topicId,
    ),
  );
  getIt.registerFactoryParam<IssueDetailViewModel, String, void>(
    (issueId, _) => IssueDetailViewModel(
      fetchIssueDetailUseCase: getIt(),
      manageIssueEvaluationUseCase: getIt(),
      manageIssueSubscriptionUseCase: getIt(),
      issueId: issueId,
    ),
  );
  getIt.registerFactory<IssueQueryParamsViewModel>(
    () => IssueQueryParamsViewModel(fetchIssueQueryParamsUseCase: getIt()),
  );

  //topic
  getIt.registerFactory<SubscribedTopicViewModel>(
    () => SubscribedTopicViewModel(
      fetchTopicsUseCase: getIt(),
      fetchIssuesUseCase: getIt(),
    ),
  );
  getIt.registerFactoryParam<WholeTopicViewModel, String, void>(
    (category, _) => WholeTopicViewModel(
      fetchTopicsUseCase: getIt(),
      manageTopicSubscriptionUseCase: getIt(),
      category: category,
    ),
  );
  getIt.registerFactoryParam<TopicDetailViewModel, String, void>(
    (topicId, _) => TopicDetailViewModel(
      fetchTopicDetailUseCase: getIt(),
      topicId: topicId,
    ),
  );

  //source
  getIt.registerFactory<SubscribedMediaViewModel>(
    () => SubscribedMediaViewModel(
      fetchSourcesUseCase: getIt(),
      fetchArticlesUseCase: getIt(),
    ),
  );
  getIt.registerFactory<WholeMediaViewModel>(
    () => WholeMediaViewModel(
      fetchSourcesUseCase: getIt(),
      manageMediaSubscriptionUseCase: getIt(),
    ),
  );
  getIt.registerFactoryParam<MediaDetailViewModel, String, void>(
    (sourceId, _) => MediaDetailViewModel(
      fetchSourceDetailUseCase: getIt(),
      sourceId: sourceId,
    ),
  );

  //my page
  getIt.registerFactory<MyPageViewModel>(
    () => MyPageViewModel(
      firebaseLoginUseCase: getIt(),
      fetchUserBiasUseCase: getIt(),
      manageUserStatusUseCase: getIt(),
    ),
  );

  //web View
  getIt.registerFactoryParam<
    WebViewViewModel,
    (String, Bias)?,
    (List<Article>, String, String)?
  >(
    (issueInfo, articleInfo) => WebViewViewModel(
      fetchArticlesUseCase: getIt(),
      issueId: issueInfo?.$1,
      bias: issueInfo?.$2,
      articles: articleInfo?.$1,
      selectedArticleId: articleInfo?.$2,
      selectedSourceId: articleInfo?.$3,
    ),
  );
}
