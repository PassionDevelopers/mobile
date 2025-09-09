import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/loading/skeleton.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/share_dasi_stand.dart';
import 'package:could_be/core/permission/permission_management.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_dialog.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/presentation/setting/notification_setting_view.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<MyPageViewModel>();
    return RegScaffold(
      isScrollPage: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegAppBar(title: '설정', iconData: Icons.settings),
            Padding(
              padding: const EdgeInsets.all(MyPaddings.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigTitle(title: '설정'),
                  SizedBox(height: MyPaddings.large),
                  BigButton(
                    text: '다시 스탠드 공유하기',
                    onPressed: () {
                      UnifiedAnalyticsHelper.logButtonTap(
                        module: 'settings',
                        buttonName: 'share_app',
                      );
                      shareDasiStand();
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
                  BigButton(
                    text: '피드백 및 문의하기',
                    onPressed: () {
                      UnifiedAnalyticsHelper.logNavigationEvent(
                        fromScreen: 'settings',
                        toScreen: 'feedback',
                      );
                      context.push(RouteNames.feedback);
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
                  BigButton(
                    text: '다시 스탠드 평가하기',
                    onPressed: () {
                      UnifiedAnalyticsHelper.logButtonTap(
                        module: 'settings',
                        buttonName: 'rate_app',
                      );
                      final InAppReview inAppReview = InAppReview.instance;
                      inAppReview.openStoreListing(appStoreId: '6748309466');
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
                  BigButton(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [MyText.h3('알림 설정')],
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return NotificationSettingView();
                        },
                      );
                      // requestFCMPermission(false);
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
                          return BigButton(
                            text: snapshot.data!,
                            onPressed: () {},
                          );
                        }
                      }
                      return BigButtonSkeleton();
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
                  BigButton(
                    text: '오픈소스 라이선스',
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => LicensePage()));
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
                  BigButton(
                    text: '서비스 이용약관',
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
                    text: '개인정보처리방침',
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
                            if (!state.isGuestLogin) BigButtonSkeleton(),
                            if (!state.isGuestLogin)
                              SizedBox(height: MyPaddings.medium),
                            BigButtonSkeleton(),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            if (!state.isGuestLogin)
                              BigButton(
                                text: '로그아웃',
                                onPressed: () async {
                                  UnifiedAnalyticsHelper.logButtonTap(
                                    module: 'settings',
                                    buttonName: 'logout',
                                  );
                                  await viewModel.signOut();
                                  UnifiedAnalyticsHelper.logAuthEvent(
                                    method: 'logout',
                                    success: true,
                                  );
                                  if (context.mounted)
                                    context.go(RouteNames.root);
                                },
                              ),
                            if (!state.isGuestLogin)
                              SizedBox(height: MyPaddings.medium),
                            BigButton(
                              text: '계정 삭제',
                              textColor: AppColors.warning,
                              onPressed: () async {
                                if (!context.mounted) return;
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder:
                                      (context) => LoginDialog(
                                        onDeleteAccount:
                                            viewModel.deleteAccount,
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
                  BottomSafePadding(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
