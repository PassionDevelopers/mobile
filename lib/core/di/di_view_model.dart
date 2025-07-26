import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/presentation/home/home_view_model.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view_model.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:could_be/presentation/media/subscribed_media/subscribed_media_view_model.dart';
import 'package:could_be/presentation/topic/topic_detail_view/topic_detail_view_model.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import '../../presentation/customer_services/feedback_view_model.dart';
import '../../presentation/issue_detail_feed/issue_detail_view_model.dart';
import '../../presentation/issue_list/issue_type.dart';
import '../../presentation/issue_list/main/issue_list_view_model.dart';
import '../../presentation/media/media_detail/media_detail_view_model.dart';
import '../../presentation/media/whole_media/whole_media_view_model.dart';
import '../../presentation/my_page/main/my_page_view_model.dart';
import '../../presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'di_setup.dart';

Future<void> diViewModelSetup() async {

  //home
  getIt.registerFactory<HomeViewModel>(
        () =>  HomeViewModel()
  );

  //issue
  getIt.registerFactoryParam<IssueListViewModel, IssueType, String?>(
        (issueType, topicId) => IssueListViewModel(
      fetchIssuesUseCase: getIt(),
      manageIssueEvaluationUseCase: getIt(),
      issueType: issueType,
      topicId: topicId, searchIssuesUseCase: getIt(),
    ),
  );
  getIt.registerFactoryParam<IssueDetailViewModel, String, void>(
        (issueId, _) => IssueDetailViewModel(
      trackUserActivityUseCase: getIt(),
      fetchIssueDetailUseCase: getIt(),
      manageIssueEvaluationUseCase: getIt(),
      manageIssueSubscriptionUseCase: getIt(),
      issueId: issueId,
    ),
  );
  getIt.registerFactory<IssueQueryParamsViewModel>(
        () => IssueQueryParamsViewModel(fetchIssueQueryParamsUseCase: getIt()),
  );
  getIt.registerFactory<HotIssuesViewModel>(
        () => HotIssuesViewModel(
      fetchHotIssuesUseCase: getIt(),
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
        (category, _) => WholeTopicViewModel(
      fetchTopicsUseCase: getIt(),
      searchTopicsUseCase: getIt(),
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
      manageSourceEvaluationUseCase: getIt(),
      manageMediaSubscriptionUseCase: getIt(),
      fetchSourceDetailUseCase: getIt(),
      sourceId: sourceId,
    ),
  );

  //my page
  getIt.registerFactory<MyPageViewModel>(
        () => MyPageViewModel(
      trackUserActivityUseCase: getIt(),
      manageUserProfileUseCase: getIt(),
      fetchWholeBiasUseCase: getIt(),
      firebaseLoginUseCase: getIt(),
      fetchUserBiasUseCase: getIt(),
      manageUserStatusUseCase: getIt(),
    ),
  );

  //feedback
  getIt.registerFactory<FeedbackViewModel>(
        () => FeedbackViewModel(getIt()),
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
      trackUserActivityUseCase: getIt(),
    ),
  );
}