import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/presentation/bias_test/bias_test_view.dart';
import 'package:could_be/presentation/customer_services/feedback_root.dart';
import 'package:could_be/presentation/home/feed_view.dart';
import 'package:could_be/presentation/hot_issue/hot_issue_view.dart';
import 'package:could_be/presentation/init/root.dart';
import 'package:could_be/presentation/issue_detail_feed/issue_detail_feed_root.dart';
import 'package:could_be/presentation/my_page/manage_issue_evaluation_view.dart';
import 'package:could_be/presentation/my_page/manage_source_evaluation/manage_source_evaluation_view.dart';
import 'package:could_be/presentation/my_page/profile_manage/profile_manage_view.dart';
import 'package:could_be/presentation/notice/notice_view.dart';
import 'package:could_be/presentation/setting/setting_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view.dart';
import 'package:could_be/presentation/update_management/have_update.dart';
import 'package:could_be/presentation/update_management/need_update.dart';
import 'package:could_be/presentation/update_management/unsupported_device.dart';
import 'package:could_be/presentation/web_view/web_view_view.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/article.dart';
import '../../presentation/blind_spot/blind_spot_root.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/media/media_detail/media_detail_view.dart';
import '../../presentation/media/subscribed_media/subscribed_media_root.dart';
import '../../presentation/media/whole_media/whole_media_view.dart';
import '../../presentation/my_page/main/my_page_view.dart';
import '../../presentation/my_page/subscribed_issue_view.dart';
import '../../presentation/my_page/watch_history_view.dart';
import '../../presentation/topic/subscribed_topic/subscribed_topic_root.dart';
import '../../presentation/topic/topic_detail_view/topic_detail_view.dart';
import '../method/bias/bias_enum.dart';

final router = GoRouter(
  initialLocation: RouteNames.root,
  routes: [
    GoRoute(path: RouteNames.root, builder: (context, state) => Root()),
    // GoRoute(
    //   path: RouteNames.login,
    //   builder:
    //       (context, state) => LoginView(
    //         onLoginSuccess: () {
    //           context.go(RouteNames.home);
    //         },
    //       ),
    // ),
    //bottom nav
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeView(
          body: navigationShell,
          currentPageIndex: navigationShell.currentIndex,
          setCurrentIndex: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (context, state) => FeedView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.topic,
              builder: (context, state) => SubscribedTopicRoot(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.blindSpot,
              builder:
                  (context, state) => BlindSpotRoot(
                    onIssueSelected:
                        (issueId) => context.push(
                          '${RouteNames.issueDetailFeed}/$issueId',
                        ),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.media,
              builder: (context, state) => SubscribedMediaRoot(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.myPage,
              builder:
                  (context, state) => MyPageView(
                    toWatchHistory: () => context.push(RouteNames.watchHistory),
                    toSubscribedIssue:
                        () => context.push(RouteNames.subscribedIssue),
                    toManageMediaSubscription:
                        () => context.push(RouteNames.wholeMedia),
                    toManageTopicSubscription:
                        () => context.push(RouteNames.wholeTopics),
                    toManageIssueEvaluation:
                        () => context.push(RouteNames.manageIssueEvalution),
                    toManageSourceEvaluation:
                        () => context.push(RouteNames.manageSourceEvaluation),
                  ),
            ),
          ],
        ),
      ],
    ),

    GoRoute(path: RouteNames.notice, builder: (context, state) => NoticeView()),
    GoRoute(
      path: RouteNames.unsupportedDevice,
      builder: (context, state) => UnsupportedDevice(),
    ),
    GoRoute(
      path: RouteNames.needUpdate,
      builder: (context, state) => NeedUpdate(isUpdate: true),
    ),
    GoRoute(
      path: RouteNames.serverCheck,
      builder: (context, state) => NeedUpdate(isUpdate: false),
    ),
    GoRoute(
      path: RouteNames.haveUpdate,
      builder:
          (context, state) =>
              HaveUpdate(latestVersionNow: state.extra as String),
    ),

    // GoRoute(
    //   path: RouteNames.shortsPlayer,
    //   builder: (context, state) {
    //     final issueId = state.pathParameters['issueId']!;
    //     return ShortsPlayerView(issueId: issueId);
    //   },
    // ),
    GoRoute(
      path: '${RouteNames.issueDetailFeed}/:id',
      builder: (context, state) {
        final issueId = state.pathParameters['id']!;
        return IssueDetailFeedRoot(issueId: issueId);
      },
    ),
    GoRoute(
      path: RouteNames.hotIssueFeed,
      builder: (context, state) {
        final hotIssues = state.extra as HotIssues;
        return HotIssueView(hotIssues: hotIssues);
      },
    ),

    //article
    GoRoute(
      path: RouteNames.webView,
      builder: (context, state) {
        final extra = state.extra! as Map<String, dynamic>;
        if (extra['issueInfo'] != null) {
          final issueId = extra['issueInfo'].$1 as String;
          final bias = extra['issueInfo'].$2 as Bias;
          return WebViewView(issueId: issueId, bias: bias);
        } else {
          final articles = extra['articleInfo'].$1 as List<Article>;
          final selectedArticleId = extra['articleInfo'].$2 as String;
          final selectedSourceId = extra['articleInfo'].$3 as String;
          return WebViewView(
            articles: articles,
            selectedArticleId: selectedArticleId,
            selectedSourceId: selectedSourceId,
          );
        }
      },
    ),

    //topic
    GoRoute(
      path: RouteNames.topicDetail,
      builder: (context, state) {
        final extra = state.extra as String;
        return TopicDetailView(topicId: extra);
      },
    ),
    GoRoute(
      path: RouteNames.wholeTopics,
      builder: (context, state) {
        return WholeTopicView();
      },
    ),

    //media
    GoRoute(
      path: RouteNames.wholeMedia,
      builder: (context, state) => WholeMediaView(),
    ),
    GoRoute(
      path: RouteNames.mediaDetail,
      builder: (context, state) {
        final sourceId = state.extra! as String;
        return MediaDetailView(sourceId: sourceId);
      },
    ),

    //my page
    GoRoute(
      path: RouteNames.watchHistory,
      builder: (context, state) => WatchHistoryView(),
    ),
    GoRoute(
      path: RouteNames.subscribedIssue,
      builder: (context, state) => SubscribedIssueView(),
    ),
    GoRoute(
      path: RouteNames.manageIssueEvalution,
      builder: (context, state) => ManageIssueEvaluationView(),
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (context, state) => SettingView(),
    ),
    GoRoute(
      path: RouteNames.manageSourceEvaluation,
      builder: (context, state) => ManageSourceEvaluationView(),
    ),
    GoRoute(
      path: RouteNames.profileManage,
      builder: (context, state) {
        final extra = state.extra as String?;
        return ProfileManageView(imageUrl: extra,);
      },
    ),
    GoRoute(
      path: RouteNames.biasTest,
      builder: (context, state) => PoliticalTestPage()
      ),

    //customer services
    GoRoute(
      path: RouteNames.feedback,
      builder: (context, state) => FeedbackRoot(),
    ),
  ],
);
