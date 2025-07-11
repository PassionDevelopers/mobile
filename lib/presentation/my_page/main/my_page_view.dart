import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/presentation/log_in/login_dialog.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/components/loading/skeleton.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../core/responsive/responsive_layout.dart';

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

    return Column(
      children: [
        RegAppBar(title: '마이페이지', iconData: Icons.account_circle_rounded, actions: [
          IconButton(
            icon: Icon(Icons.settings, size: 30,),
            onPressed: () {
              context.push(RouteNames.settings);
            },
          ),
        ],),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MyPaddings.large,
                        vertical: MyPaddings.large,
                      ),
                      child: Column(
                        children: [
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: ListenableBuilder(
                          //     listenable: viewModel,
                          //     builder: (context, _) {
                          //       final state = viewModel.state;
                          //       if (state.isBiasLoading) {
                          //         return BigButtonSkeleton();
                          //       } else if (state.userBias == null) {
                          //         return BigButtonSkeleton();
                          //       } else {
                          //         return Row(
                          //           children: [
                          //             MyText.h2(
                          //               state.userBias!.nickname,
                          //               color: AppColors.primary,
                          //             ),
                          //             Container(
                          //               margin: EdgeInsets.only(left: MyPaddings.small),
                          //               decoration: BoxDecoration(
                          //                 color: AppColors.primary.withValues(alpha: 0.1),
                          //                 borderRadius: BorderRadius.circular(8),
                          //                 shape: BoxShape.circle,
                          //               ),
                          //               child: MyText.h3(
                          //                 state.userBias!.bias.name,
                          //                 color: AppColors.primary,
                          //               ),
                          //             )
                          //           ],
                          //         );
                          //       }
                          //     },
                          //   ),
                          // ),
          
                          // BigTitle(title: '나의 성향'),
                          // SizedBox(height: MyPaddings.large),
                          // ListenableBuilder(
                          //   listenable: viewModel,
                          //   builder: (context, _) {
                          //     final state = viewModel.state;
                          //     if (state.isBiasLoading) {
                          //       return BigButtonSkeleton();
                          //     } else if (state.userBias == null) {
                          //       return BigButtonSkeleton();
                          //     } else {
                          //       return BigButton(
                          //         '나의 성향 : ${getBiasName(state.userBias!.bias)}',
                          //         onPressed: toUserBiasStatus,
                          //       );
                          //     }
                          //   },
                          // ),
          
                          // SizedBox(height: MyPaddings.large),
                          BigTitle(title: '나의 관심 항목'),
                          SizedBox(height: MyPaddings.large),
          
                          BigButton('나의 관심 이슈', onPressed: toSubscribedIssue),
                          SizedBox(height: MyPaddings.medium),
                          BigButton('나의 관심 언론', onPressed: toManageMediaSubscription),
                          SizedBox(height: MyPaddings.medium),
                          BigButton('나의 관심 토픽', onPressed: toManageTopicSubscription),
          
                          SizedBox(height: MyPaddings.large),
                          BigTitle(title: '나의 활동'),
                          SizedBox(height: MyPaddings.large),
          
                          BigButton('내가 본 이슈', onPressed: toWatchHistory),
                          SizedBox(height: MyPaddings.medium),
                          BigButton('내가 평가한 이슈', onPressed: toManageIssueEvaluation),
          
          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if(viewModel.state.isGuestLogin)Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.black.withAlpha(180)
                  ),
                  child: LoginView(onLoginSuccess: () {  },),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
