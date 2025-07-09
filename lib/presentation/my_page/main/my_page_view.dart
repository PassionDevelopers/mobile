import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/log_in/login_dialog.dart';
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

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<MyPageViewModel>();

    return SingleChildScrollView(
      child: Column(
      children: [
        RegAppBar(title: '마이페이지', iconData: Icons.account_circle_rounded),
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

              SizedBox(height: MyPaddings.large),
              BigTitle(title: '설정'),
              SizedBox(height: MyPaddings.large),

              BigButton(
                '피드백 및 문의하기',
                onPressed: () => context.push(RouteNames.feedback),
              ),
              SizedBox(height: MyPaddings.medium),
              BigButton(
                '다시 스탠드 평가하기',
                onPressed: () {
                  final InAppReview inAppReview = InAppReview.instance;
                  inAppReview.openStoreListing(appStoreId: '6739764701');
                },
              ),
              SizedBox(height: MyPaddings.medium),
              FutureBuilder<String>(
                future: getVersion(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<String> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return BigButton(snapshot.data!, onPressed: () {});
                    }
                  }
                  return BigButtonSkeleton();
                },
              ),
              SizedBox(height: MyPaddings.medium),
              BigButton(
                '오픈소스 라이선스',
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => LicensePage()));
                },
              ),
              SizedBox(height: MyPaddings.medium),
              BigButton(
                '서비스 이용약관',
                onPressed: () async {
                  final Uri url = Uri.parse(
                    'https://passiondevelopers.github.io/docs_hosting/%EC%95%BD%EA%B4%80.html',
                  );
                  if (!await launchUrl(url)) {
                    throw Exception('페이지를 로드할 수 없습니다.');
                  }
                },
              ),
              SizedBox(height: MyPaddings.medium),

              BigButton(
                '개인정보처리방침',
                onPressed: () async {
                  final Uri url = Uri.parse(
                    'https://passiondevelopers.github.io/docs_hosting/privacy-policy-dasi-stand.html',
                  );
                  if (!await launchUrl(url)) {
                    throw Exception('페이지를 로드할 수 없습니다.');
                  }
                },
              ),

              SizedBox(height: MyPaddings.large),
              BigTitle(title: '계정 관리'),
              SizedBox(height: MyPaddings.large),

              ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  final state = viewModel.state;
                  if (state.isUserStatusLoading) {
                    return Column(
                      children: [
                        BigButtonSkeleton(),
                        SizedBox(height: MyPaddings.medium),
                        BigButtonSkeleton(),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        state.isUserStatusLoading
                            ? BigButtonSkeleton()
                            : BigButton(
                              '로그아웃',
                              onPressed: () async {
                                await viewModel.signOut();
                                if (context.mounted)
                                  context.go(RouteNames.login);
                              },
                            ),
                        SizedBox(height: MyPaddings.medium),
                        state.isUserStatusLoading
                            ? BigButtonSkeleton()
                            : BigButton(
                              '계정 삭제',
                              textColor: AppColors.warning,
                              onPressed: () async {
                                if (!context.mounted) return;
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder:
                                      (context) => LoginDialog(
                                    onDeleteAccount: viewModel.deleteAccount,
                                  ),
                                );
                              },
                            ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: MyPaddings.medium),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
