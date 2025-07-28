import 'dart:async';

import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/di/di_setup.dart';
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
              onTap: widget.toSubscribedIssue,
            ),
            _buildActionTile(
              icon: Icons.newspaper_outlined,
              title: '관심 언론',
              count: '',
              onTap: widget.toManageMediaSubscription,
            ),
            _buildActionTile(
              icon: Icons.tag,
              title: '관심 토픽',
              count: '',
              onTap: widget.toManageTopicSubscription,
            ),
            _buildActionTile(
              icon: Icons.history_outlined,
              title: '본 이슈',
              count: '',
              onTap: widget.toWatchHistory,
            ),
            _buildActionTile(
              icon: Icons.star_outline,
              title: '평가한 이슈',
              count: '',
              onTap: widget.toManageIssueEvaluation,
            ),
            _buildActionTile(
              icon: Icons.analytics_outlined,
              title: '평가한 언론',
              count: '',
              onTap: widget.toManageSourceEvaluation,
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
  }

  @override
  void dispose() {
    eventSubscription?.cancel();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SingleChildScrollView(
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
              MyPageHeader(viewModel: viewModel),
              SizedBox(height: MyPaddings.extraLarge),
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
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            if (viewModel.state.isGuestLogin) {
              return Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.black.withAlpha(180),
                  ),
                  child: LoginView(
                    onLoginSuccess: () {
                      viewModel.checkIsGuestLogin();
                    },
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
