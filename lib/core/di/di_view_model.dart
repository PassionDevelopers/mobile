import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/article/article.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view_model.dart';
import 'package:could_be/presentation/home/home_view_model.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view_model.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:could_be/presentation/main_feed/main_feed_view_model.dart';
import 'package:could_be/presentation/my_page/manage_source_evaluation/manage_source_evaluation_view_model.dart';
import 'package:could_be/presentation/my_page/profile_manage/profile_manage_view_model.dart';
import 'package:could_be/presentation/notice/notice_dialog/notice_dialog_view_model.dart';
import 'package:could_be/presentation/notice/notice_view_model.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_result/bias_test_result_view_model.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_view_model.dart';
import 'package:could_be/presentation/search/main/search_view_model.dart';
import 'package:could_be/presentation/setting/notification_setting_view_model.dart';
import 'package:could_be/presentation/source/media_detail/media_detail_view_model.dart';
import 'package:could_be/presentation/source/subscribed_media/subscribed_media_view_model.dart';
import 'package:could_be/presentation/source/whole_media/whole_media_view_model.dart';
import 'package:could_be/presentation/topic/topic_detail_view/topic_detail_view_model.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/customer_services/feedback_view_model.dart';
import '../../presentation/issue_detail_feed/issue_detail_view_model.dart';
import '../../presentation/issue_list/issue_type.dart';
import '../../presentation/issue_list/main/issue_list_view_model.dart';
import '../../presentation/my_page/main/my_page_view_model.dart';
import '../../presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'di_setup.dart';

Future<void> diViewModelSetup() async {
  //bias test
  getIt.registerFactory<BiasTestViewModel>(
        () => BiasTestViewModel(onboardingUseCase: getIt()),
  );
  getIt.registerFactoryParam<BiasTestResultViewModel, List<BiasQuizAnswerVo>, void>(
        (answers, _) => BiasTestResultViewModel(onboardingUseCase: getIt(), answers: answers),
  );

  //notice
  getIt.registerFactory<NoticeViewModel>(
        () => NoticeViewModel(getIt()),
  );
  getIt.registerFactoryParam<NoticeDialogViewModel, Notice, void>(
        (notice, _) =>
        NoticeDialogViewModel(
          fetchNoticeUseCase: getIt(),
          notice: notice,
        ),
  );
  //home
  getIt.registerFactory<HomeViewModel>(
        () => HomeViewModel(fetchNoticeUseCase: getIt()),
  );

  //comment
  getIt.registerFactoryParam<CommentViewModel, String, void>(
        (issueId, _) => CommentViewModel(
          issueId: issueId,
          commentUseCase: getIt(),
          manageUserProfileUseCase: getIt(),
        ),
  );
  
  getIt.registerFactoryParam<CommentInputViewModel, String, void>(
      (issueId, addComment) => CommentInputViewModel(
        issueId: issueId,
        commentUseCase: getIt(),
        manageUserProfileUseCase: getIt(),
      ),
  );

  //issue
  getIt.registerFactoryParam<IssueListViewModel, IssueType, String?>(
        (issueType, topicId) =>
        IssueListViewModel(
          fetchIssuesUseCase: getIt(),
          manageIssueEvaluationUseCase: getIt(),
          issueType: issueType,
          topicId: topicId,
          searchIssuesUseCase: getIt(),
        ),
  );
  getIt.registerFactoryParam<IssueDetailViewModel, String, void>(
        (issueId, _) =>
        IssueDetailViewModel(
          manageUserProfileUseCase: getIt(),
          commentUseCase: getIt(),
          trackUserActivityUseCase: getIt(),
          firebaseLoginUseCase: getIt(),
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
        () =>
        HotIssuesViewModel(
          fetchHotIssuesUseCase: getIt(),
        ),
  );
  getIt.registerFactory<MainFeedViewModel>(
        () =>
        MainFeedViewModel(
          fetchIssuesUseCase: getIt(),
          searchIssuesUseCase: getIt(),
        ),
  );

  //topic
  getIt.registerFactory<SubscribedTopicViewModel>(
        () =>
        SubscribedTopicViewModel(
          fetchTopicsUseCase: getIt(),
          fetchIssuesUseCase: getIt(),
        ),
  );
  getIt.registerFactoryParam<WholeTopicViewModel, Categories, void>(
        (category, _) =>
        WholeTopicViewModel(
          firebaseLoginUseCase: getIt(),
          fetchTopicsUseCase: getIt(),
          manageTopicSubscriptionUseCase: getIt(),
          category: category,
        ),
  );
  getIt.registerFactory<SearchViewModel>(
        () =>
        SearchViewModel(
          searchTopicsUseCase: getIt(),
        ),
  );
  getIt.registerFactoryParam<TopicDetailViewModel, String, void>(
        (topicId, _) =>
        TopicDetailViewModel(
          fetchTopicDetailUseCase: getIt(),
          topicId: topicId,
        ),
  );

  //source
  getIt.registerFactory<SubscribedMediaViewModel>(
        () =>
        SubscribedMediaViewModel(
          fetchSourcesUseCase: getIt(),
          fetchArticlesUseCase: getIt(),
          routeService: getIt(),
        ),
  );
  getIt.registerFactory<WholeMediaViewModel>(
        () =>
        WholeMediaViewModel(
          fetchSourcesUseCase: getIt(),
          firebaseLoginUseCase: getIt(),
          manageMediaSubscriptionUseCase: getIt(),
        ),
  );
  getIt.registerFactoryParam<MediaDetailViewModel, String, void>(
        (sourceId, _) =>
        MediaDetailViewModel(
          firebaseLoginUseCase: getIt(),
          manageSourceEvaluationUseCase: getIt(),
          manageMediaSubscriptionUseCase: getIt(),
          fetchSourceDetailUseCase: getIt(),
          sourceId: sourceId,
        ),
  );

  //my page
  getIt.registerFactory<MyPageViewModel>(() =>
      MyPageViewModel(
        trackUserActivityUseCase: getIt(),
        manageUserProfileUseCase: getIt(),
        fetchWholeBiasUseCase: getIt(),
        firebaseLoginUseCase: getIt(),
        manageUserStatusUseCase: getIt(),
      ),
  );
  getIt.registerFactory<ManageSourceEvaluationViewModel>(
        () =>
        ManageSourceEvaluationViewModel(
          manageSourceEvaluationUseCase: getIt(),
          fetchSourcesUseCase: getIt(),
        ),
  );
  getIt.registerFactoryParam<ProfileManageViewModel, BuildContext, String?>(
          (context, imageUrl) =>
          ProfileManageViewModel(
            imageUrl: imageUrl,
              context: context, manageUserProfileUsecase: getIt())
  );
  getIt.registerFactory<NotificationSettingViewModel>(
        () => NotificationSettingViewModel(
      notificationsUseCase: getIt(),
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
        (issueInfo, articleInfo) =>
        WebViewViewModel(
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