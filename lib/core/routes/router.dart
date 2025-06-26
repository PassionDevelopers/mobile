import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/home/feed_view.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:could_be/presentation/media/main/subscribed_media_root.dart';
import 'package:could_be/presentation/my_page/user_bias_status/user_bias_status_view.dart';
import 'package:could_be/presentation/shorts/shorts_root.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view.dart';
import 'package:could_be/presentation/web_view/web_view_view.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blind_spot/blind_spot_root.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/media/whole_media/whole_media_view.dart';
import '../../presentation/my_page/main/my_page_view.dart';
import '../../presentation/my_page/subscribed_issue_view.dart';
import '../../presentation/my_page/watch_history_view.dart';
import '../../presentation/topic/topic_detail_view.dart';
import '../components/bias/bias_enum.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouteNames.login,
      builder:
          (context, state) => LoginView(
            onLoginSuccess: () {
              context.go(RouteNames.home);
            },
          ),
    ),
    GoRoute(
      path: RouteNames.shortsView,
      builder: (context, state) {
        final issueId = state.pathParameters['issueId']!;
        return ShortsRoot(issueId: issueId);
      },
    ),

    //article
    GoRoute(
      path: RouteNames.webView,
      builder: (context, state) {
        final extra = state.extra! as Map<String, dynamic>;
        if(extra['isIssueId']) {
          final issueId = extra['issueId'] as String;
          final bias = extra['bias'] as Bias;
          return WebViewView(issueId: issueId, bias: bias);
        }else{
          return WebViewView(article: extra['article']);
        }
      },
    ),

    //topic
    GoRoute(
      path: RouteNames.topicDetail,
      builder: (context, state) => TopicDetailView(),
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
      path: RouteNames.userBiasStatus,
      builder: (context, state) => UserBiasStatusView(),
    ),

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
              builder:
                  (context, state) => FeedView(
                    onIssueSelected:
                        (issueId) =>
                            context.push(RouteNames.shortsView + issueId),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.topic,
              builder: (context, state) => SubscribedTopicView(),
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
                        (issueId) =>
                            context.push(RouteNames.shortsView + issueId),
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
                    toUserBiasStatus:
                        () => context.push(RouteNames.userBiasStatus),
                    toManageMediaSubscription:
                        () => context.push(RouteNames.wholeMedia),
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
