import 'dart:async';

import 'package:could_be/presentation/log_in/login_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/events/tab_reselection_event.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:could_be/presentation/my_page/components/my_page_header.dart';
import 'package:could_be/presentation/my_page/components/my_page_hexagon.dart';
import 'package:could_be/presentation/my_page/components/my_page_trend_chart.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/themes/margins_paddings.dart';
import '../../../core/analytics/unified_analytics_helper.dart';
import '../../../core/analytics/analytics_event_names.dart';
import '../../../core/analytics/analytics_parameter_keys.dart';
import '../../../core/analytics/analytics_screen_names.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    super.key,
    required this.toWatchHistory,
    required this.toSubscribedIssue,
    required this.toManageMediaSubscription,
    required this.toManageIssueEvaluation,
    required this.toManageTopicSubscription,
    required this.toManageSourceEvaluation,
  });

  final VoidCallback toWatchHistory;
  final VoidCallback toSubscribedIssue;
  final VoidCallback toManageMediaSubscription;
  final VoidCallback toManageTopicSubscription;
  final VoidCallback toManageIssueEvaluation;
  final VoidCallback toManageSourceEvaluation;

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late final MyPageViewModel viewModel;
  final ScrollController scrollController = ScrollController();
  StreamSubscription<int>? _tabReselectionSubscription;
  StreamSubscription<User?>? _authStateSubscription;

  Widget _buildQuickActionsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.h2('나의 활동', color: AppColors.primary),
        SizedBox(height: MyPaddings.large),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: MyPaddings.medium,
          crossAxisSpacing: MyPaddings.medium,
          children: [
            _buildActionTile(
              icon: Icons.bookmark_outline,
              title: '관심 이슈',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'subscribed_issues'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_subscribed_issues',
                  },
                );
                widget.toSubscribedIssue();
              },
            ),
            _buildActionTile(
              icon: Icons.newspaper_outlined,
              title: '관심 언론',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'subscribed_media'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_subscribed_media',
                  },
                );
                widget.toManageMediaSubscription();
              },
            ),
            _buildActionTile(
              icon: Icons.tag,
              title: '관심 토픽',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'subscribed_topics'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_subscribed_topics',
                  },
                );
                widget.toManageTopicSubscription();
              },
            ),
            _buildActionTile(
              icon: Icons.history_outlined,
              title: '본 이슈',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'watch_history'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_watch_history',
                  },
                );
                widget.toWatchHistory();
              },
            ),
            _buildActionTile(
              icon: Icons.star_outline,
              title: '평가한 이슈',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'evaluated_issues'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_evaluated_issues',
                  },
                );
                widget.toManageIssueEvaluation();
              },
            ),
            _buildActionTile(
              icon: Icons.analytics_outlined,
              title: '평가한 언론',
              count: '',
              onTap: () {
                UnifiedAnalyticsHelper.logEvent(
                  name: AnalyticsEventNames.buttonTap('my_page', 'evaluated_media'),
                  parameters: {
                    AnalyticsParameterKeys.module: AnalyticsScreenNames.myPageScreen,
                    AnalyticsParameterKeys.action: 'tap_evaluated_media',
                  },
                );
                widget.toManageSourceEvaluation();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String count,
    required VoidCallback onTap,
    bool isActive = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: EdgeInsets.all(MyPaddings.medium),
        decoration: BoxDecoration(
          color: isActive? AppColors.white : AppColors.gray4,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray5, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            SizedBox(height: MyPaddings.small),
            Text(
              title,
              style: MyFontStyle.small.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (count.isNotEmpty) ...[
              SizedBox(height: 2),
              Text(
                count,
                style: MyFontStyle.small.copyWith(
                  color: AppColors.gray2,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  StreamSubscription? eventSubscription;
  @override
  void initState() {
    super.initState();
    viewModel = getIt<MyPageViewModel>();
    eventSubscription = viewModel.eventStream.listen((event) {
      if (mounted) {
        showAlert(context: context, msg: event.toString());
      }
    });
    
    // Firebase Auth 상태 변경 리스너 추가
    _authStateSubscription = getIt<FirebaseAuth>().authStateChanges().listen((User? user) {
      if (mounted) {
        // 로그인 상태가 변경되었을 때 (로그인/로그아웃)
        viewModel.refresh();
      }
    });
    
    // 탭 재선택 이벤트 리스닝
    _tabReselectionSubscription = TabReselectionEvent.stream.listen((tabIndex) {
      // 마이페이지 탭(4)이 재선택되었을 때
      if (tabIndex == 4) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    eventSubscription?.cancel();
    _authStateSubscription?.cancel();
    _tabReselectionSubscription?.cancel();
    scrollController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.refresh();
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                RegAppBar(
                  title: '마이페이지',
                  iconData: Icons.account_circle_rounded,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.settings, size: 30),
                      onPressed: () {
                        context.push(RouteNames.settings);
                      },
                    ),
                  ],
                ),
                SizedBox(height: MyPaddings.extraLarge),
                InkWell(
                  onTap: () {
                    context.push(RouteNames.biasTest);
                  },
                  child: Ink(
                    padding: EdgeInsets.all(MyPaddings.large),
                    // margin: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray3.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text('정치성향 테스트'),
                  ),
                ),
                SizedBox(height: MyPaddings.extraLarge),
                MyPageHeader(viewModel: viewModel),
                SizedBox(height: MyPaddings.extraLarge),
                if(viewModel.state.isGuestLogin) LoginPopUp(isMyPage: true,) ,
                if(viewModel.state.isGuestLogin) SizedBox(height: MyPaddings.extraLarge),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                  ),
                  child: Column(
                    children: [
                      // Bias Card
                      MyPageHexagon(viewModel: viewModel),

                      SizedBox(height: MyPaddings.extraLarge),

                      // Quick Actions Grid
                      _buildQuickActionsGrid(),

                      SizedBox(height: MyPaddings.extraLarge),

                      // Trend Section
                      MyPageTrendChart(viewModel: viewModel),

                      SizedBox(height: MyPaddings.extraLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ListenableBuilder(
          //   listenable: viewModel,
          //   builder: (context, _) {
          //     if (viewModel.state.isGuestLogin) {
          //       return Center(
          //         child: Container(
          //           width: double.infinity,
          //           height: double.infinity,
          //           decoration: BoxDecoration(
          //             color: AppColors.black.withAlpha(180),
          //           ),
          //           child: LoginView(
          //             onLoginSuccess: () {
          //               viewModel.checkIsGuestLogin();
          //               viewModel.refresh();
          //             },
          //           ),
          //         ),
          //       );
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
