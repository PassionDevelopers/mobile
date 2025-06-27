import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/data/repositoryImpl/manage_topic_subscription_repository_impl.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositoryImpl/articles_repository_impl.dart';
import '../../data/repositoryImpl/issue_detail_repository_impl.dart';
import '../../data/repositoryImpl/issues_repository_impl.dart';
import '../../data/repositoryImpl/manage_issue_subscription_repository_impl.dart';
import '../../data/repositoryImpl/manage_media_subscription_repository_impl.dart';
import '../../data/repositoryImpl/sources_repository_impl.dart';
import '../../data/repositoryImpl/topics_repository_impl.dart';
import '../../data/repositoryImpl/user_bias_repository_impl.dart';
import '../../domain/useCases/fetch_articles_use_case.dart';
import '../../domain/useCases/fetch_issues_use_case.dart';
import '../../domain/useCases/fetch_sources_use_case.dart';
import '../../domain/useCases/fetch_topics_use_case.dart';
import '../../domain/useCases/fetch_user_bias_user_case.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';
import '../../domain/useCases/manage_issue_subscription_use_case.dart';
import '../../domain/useCases/manage_media_subscription_use_case.dart';
import '../../domain/useCases/manage_topic_subscription_use_case.dart';
import '../../presentation/issue_list/issue_type.dart';
import '../../presentation/issue_list/main/issue_list_view_model.dart';
import '../../presentation/media/main/subscribed_media_view_model.dart';
import '../../presentation/media/whole_media/whole_media_view_model.dart';
import '../../presentation/my_page/main/my_page_view_model.dart';
import '../../presentation/shorts/shorts_view_model.dart';
import '../../presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'api.dart';

final getIt = GetIt.instance;

//한군데서 di setup을 관리할 수 있다.
void diSetup() {
  //useCase
  //issue
  getIt.registerSingleton(FetchIssuesUseCase(IssuesRepositoryImpl(dio)));
  getIt.registerSingleton(
    FetchIssueDetailUseCase(IssueDetailRepositoryImpl(dio)),
  );
  getIt.registerSingleton(
    ManageIssueSubscriptionUseCase(ManageIssueSubscriptionRepositoryImpl(dio)),
  );

  //user
  getIt.registerSingleton(FetchUserBiasUseCase(UserBiasRepositoryImpl(dio)));
  //articles
  getIt.registerSingleton(FetchArticlesUseCase(ArticlesRepositoryImpl(dio)));

  //topic
  getIt.registerSingleton(FetchTopicsUseCase(TopicsRepositoryImpl(dio)));
  getIt.registerSingleton(
    ManageTopicSubscriptionUseCase(ManageTopicSubscriptionRepositoryImpl(dio)),
  );

  //source
  getIt.registerSingleton(FetchSourcesUseCase(SourcesRepositoryImpl(dio)));
  getIt.registerSingleton(
    ManageMediaSubscriptionUseCase(ManageMediaSubscriptionRepositoryImpl(dio)),
  );
  ///////////////////////////////////////////////////////////////////////////

  //viewModel
  //issue
  getIt.registerFactoryParam<IssueListViewModel, IssueType, String?>(
    (issueType, topicId) => IssueListViewModel(
      fetchIssuesUseCase: getIt(),
      issueType: issueType,
      topicId: topicId,
    ),
  );
  getIt.registerFactoryParam<ShortsViewModel, String, void>(
    (issueId, _) => ShortsViewModel(
      fetchIssueDetailUseCase: getIt(),
      manageIssueSubscriptionUseCase: getIt(),
      issueId: issueId,
    ),
  );

  //topic
  getIt.registerFactory<SubscribedTopicViewModel>(
    () => SubscribedTopicViewModel(
      fetchTopicsUseCase: getIt(),
      fetchIssuesUseCase: getIt(),
    ),
  );
  getIt.registerFactoryParam<WholeTopicViewModel, String, void>(
    (category, _) =>
        WholeTopicViewModel(fetchTopicsUseCase: getIt(), manageTopicSubscriptionUseCase: getIt(), category: category),
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

  //my page
  getIt.registerFactory<MyPageViewModel>(
    () => MyPageViewModel(fetchUserBiasUseCase: getIt()),
  );

  //web View
  getIt.registerFactoryParam<WebViewViewModel, (String, Bias)? , Article?>(
    (issueInfo, article) => WebViewViewModel(
        fetchArticlesUseCase: getIt(),
        issueId: issueInfo?.$1,
        bias: issueInfo?.$2,
        article: article
    )
  );
}
