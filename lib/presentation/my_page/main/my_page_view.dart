import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/loading/skeleton.dart';
import '../../../core/themes/margins_paddings.dart';

class MyPageView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final viewModel = getIt<MyPageViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MyPaddings.large,
        vertical: MyPaddings.large,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BigTitle(title: '나의 성향'),
            SizedBox(height: MyPaddings.large),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final state = viewModel.state;
                if (state.isBiasLoading) {
                  return BigButtonSkeleton();
                } else if (state.userBias == null) {
                  return BigButtonSkeleton();
                } else {
                  return BigButton(
                    '나의 성향 : ${state.userBias!}',
                    onPressed: toUserBiasStatus,
                  );
                }
              },
            ),
            SizedBox(height: MyPaddings.large),
            BigTitle(title: '나의 관심 항목'),
            SizedBox(height: MyPaddings.large),

            BigButton('나의 관심 이슈', onPressed: toSubscribedIssue),
            SizedBox(height: MyPaddings.medium),
            BigButton('나의 관심 매체', onPressed: toManageMediaSubscription),
            SizedBox(height: MyPaddings.medium),
            BigButton('나의 관심 토픽', onPressed: toManageTopicSubscription),

            SizedBox(height: MyPaddings.large),
            BigTitle(title: '나의 활동'),
            SizedBox(height: MyPaddings.large),

            BigButton('내가 본 이슈', onPressed: toWatchHistory),
            SizedBox(height: MyPaddings.medium),
            BigButton('내가 평가한 이슈', onPressed: toManageIssueEvaluation),
            SizedBox(height: MyPaddings.medium),

            SizedBox(height: MyPaddings.large),
            BigTitle(title: '계정 관리'),
            SizedBox(height: MyPaddings.large),

            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final state = viewModel.state;
                if (state.isUserStatusLoading) {
                  return BigButtonSkeleton();
                } else {
                  return Column(
                    children: [
                      state.isUserStatusLoading
                          ? BigButtonSkeleton()
                          : BigButton(
                            '로그아웃',
                            onPressed: () async {
                              await viewModel.signOut();
                              if(context.mounted) context.go(RouteNames.login);
                            },
                          ),
                      SizedBox(height: MyPaddings.medium),
                      state.isUserStatusLoading
                          ? BigButtonSkeleton()
                          : BigButton(
                            '계정 삭제',
                            textColor: AppColors.warning,
                            onPressed: () async {
                              // await viewModel.deleteAccount();
                            },
                          ),
                      SizedBox(height: MyPaddings.medium),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
