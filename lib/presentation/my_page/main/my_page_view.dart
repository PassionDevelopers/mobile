import 'dart:developer';

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/presentation/my_page/my_page_integrated_view.dart';
import 'package:could_be/presentation/my_page/user_bias_status/my_bias_status_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/loading/skeleton.dart';
import '../../../core/themes/margins_paddings.dart';
import '../linear_chart_view.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    super.key,
    required this.toWatchHistory,
    required this.toSubscribedIssue,
    required this.toUserBiasStatus,
    required this.toManageMediaSubscription,
    required this.toManageIssueEvaluation,
    required this.toManageTopicSubscription,
  });

  final VoidCallback toWatchHistory;
  final VoidCallback toSubscribedIssue;
  final VoidCallback toUserBiasStatus;
  final VoidCallback toManageMediaSubscription;
  final VoidCallback toManageTopicSubscription;
  final VoidCallback toManageIssueEvaluation;

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {

  Widget _buildMinimalProfileHeader(MyPageViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: MyPaddings.large),
        child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              final state = viewModel.state;
              if (state.isBiasLoading || state.userBias == null) {
                return CircularProgressIndicator(color: AppColors.primary);
              }
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: MyPaddings.large),
                    child: Row(
                      children: [
                        // Profile Image
                        Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.gray5,
                                border: Border.all(
                                  color: getBiasColor(
                                    state.userBias!.bias,
                                  ).withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 35,
                                color: AppColors.gray2,
                              ),
                            ),
                            if (state.isEditMode)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: MyPaddings.large),
                        // Name and Score
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!state.isEditMode)
                                MyText.h1(
                                  state.userBias!.nickname,
                                  color: AppColors.primary,
                                )
                              else
                                TextField(
                                  controller: state.nicknameController,
                                  style: MyFontStyle.h1.copyWith(
                                    color: AppColors.primary,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: MyPaddings.medium,
                                      vertical: MyPaddings.small,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: MyPaddings.small),
                              if (!state.isEditMode)
                                _buildCompactScoreSection()
                              else
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: viewModel.updateUserNickname,
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MyPaddings.large,
                                          vertical: MyPaddings.small,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8),
                                        ),
                                      ),
                                      child: Text(
                                        '저장',
                                        style: MyFontStyle.small.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MyPaddings.small),
                                    TextButton(
                                      onPressed: viewModel.setEditMode,
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MyPaddings.large,
                                          vertical: MyPaddings.small,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          side: BorderSide(
                                              color: AppColors.gray4),
                                        ),
                                      ),
                                      child: Text(
                                        '취소',
                                        style: MyFontStyle.small.copyWith(
                                          color: AppColors.gray2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit button
                  if (!viewModel.state.isEditMode)
                    Positioned(
                      top: MyPaddings.large,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          viewModel.setEditMode();
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.gray5,
                          padding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                ],
              )
                ;}
              ));
            }

            Widget _buildMainContent(MyPageViewModel viewModel) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
    child: Column(
    children: [
    // Bias Card
    ListenableBuilder(
    listenable: viewModel,
    builder: (context, _) {
    final state = viewModel.state;
    if (state.isBiasLoading || state.userBias == null) {
    return SizedBox.shrink();
    }
    return _buildModernBiasCard(state.userBias!.bias);
    },
    ),

    SizedBox(height: MyPaddings.extraLarge),

    // Quick Actions Grid
    _buildQuickActionsGrid(),

    SizedBox(height: MyPaddings.extraLarge),

    // Trend Section
    _buildModernTrendCard(),
    ],
    ),
    );
    }

        Widget _buildCompactScoreSection()
    {
      const score = 87;
      const maxScore = 100;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.stars_rounded, color: AppColors.primary, size: 16),
              SizedBox(width: 4),
              Text(
                '다시 스코어',
                style: MyFontStyle.small.copyWith(color: AppColors.gray2),
              ),
              SizedBox(width: MyPaddings.small),
              Text(
                '$score',
                style: MyFontStyle.h3.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '/$maxScore',
                style: MyFontStyle.small.copyWith(color: AppColors.gray2),
              ),
            ],
          ),
          SizedBox(height: MyPaddings.small),
          // Compact Progress Bar
          Container(
            height: 4,
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.gray5,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.87,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      );
    }

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
                count: '12',
                onTap: widget.toSubscribedIssue,
              ),
              _buildActionTile(
                icon: Icons.newspaper_outlined,
                title: '관심 언론',
                count: '8',
                onTap: widget.toManageMediaSubscription,
              ),
              _buildActionTile(
                icon: Icons.tag,
                title: '관심 토픽',
                count: '5',
                onTap: widget.toManageTopicSubscription,
              ),
              _buildActionTile(
                icon: Icons.history_outlined,
                title: '본 이슈',
                count: '152',
                onTap: widget.toWatchHistory,
              ),
              _buildActionTile(
                icon: Icons.star_outline,
                title: '평가한 이슈',
                count: '24',
                onTap: widget.toManageIssueEvaluation,
              ),
              _buildActionTile(
                icon: Icons.analytics_outlined,
                title: '나의 성향',
                count: '',
                onTap: widget.toUserBiasStatus,
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
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(MyPaddings.medium),
          decoration: BoxDecoration(
            color: AppColors.white,
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

    Widget _buildModernBiasCard(Bias bias) {
      return Container(
        padding: EdgeInsets.all(MyPaddings.extraLarge),
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
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.reg('나의 성향', color: AppColors.gray2),
                    SizedBox(height: MyPaddings.small),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: getBiasColor(bias),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: MyPaddings.small),
                        MyText.h1(getBiasName(bias), color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: getBiasColor(bias).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: getBiasIcon(bias),
                ),
              ],
            ),

            SizedBox(height: MyPaddings.extraLarge),

            // Radar Chart
            Container(height: 180, child: UserExpRadar()),

            SizedBox(height: MyPaddings.large),

            // Description
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MyPaddings.large,
                vertical: MyPaddings.medium,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray5,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.gray2, size: 18),
                  SizedBox(width: MyPaddings.medium),
                  Expanded(
                    child: Text(
                      '다양한 시각을 균형 있게 이해하고 있어요.',
                      style: MyFontStyle.small.copyWith(
                        color: AppColors.gray1,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildModernTrendCard() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray3.withOpacity(0.05),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(MyPaddings.extraLarge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.small('성향 변화 추이', color: AppColors.gray2),
                      SizedBox(height: MyPaddings.small),
                      MyText.h1('최근 3개월', color: AppColors.primary),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Chart
            Container(
              height: 220,
              padding: EdgeInsets.all(MyPaddings.large),
              decoration: BoxDecoration(
                color: AppColors.gray5,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DailyUserDataChart(),
            ),

            SizedBox(height: MyPaddings.extraLarge),

            // Summary
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MyPaddings.extraLarge,
                vertical: MyPaddings.large,
              ),
              padding: EdgeInsets.all(MyPaddings.extraLarge),
              decoration: BoxDecoration(
                color: AppColors.gray5,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: MyPaddings.medium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.h3('성향 변화 분석', color: AppColors.primary),
                        SizedBox(height: MyPaddings.small),
                        Text(
                          '처음보다 더 균형 잡힌 관점으로 변화하고 있습니다.',
                          style: MyFontStyle.reg.copyWith(
                            color: AppColors.gray2,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      final viewModel = getIt<MyPageViewModel>();

      return Column(
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
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMinimalProfileHeader(viewModel),
                      _buildMainContent(viewModel),
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
            ),
          ),
        ],
      );
    }
  }
