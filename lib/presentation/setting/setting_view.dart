import 'dart:io';

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/loading/skeleton.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_dialog.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
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
                    '다시 스탠드 공유하기',
                    onPressed: (){
                      final storeUrl = Uri.parse(
                          Platform.isIOS?
                          'https://apps.apple.com/kr/app/%EB%8B%A4%EC%8B%9C-%EC%8A%A4%ED%83%A0%EB%93%9C-%EB%8B%A4%EC%96%91%ED%95%9C-%EC%8B%9C%EA%B0%81%EC%9D%98-%EB%89%B4%EC%8A%A4-%EC%8A%A4%ED%83%A0%EB%93%9C/id6748309466'
                          : 'https://play.google.com/store/apps/details?id=com.PassionDev.DasiStand'
                      );
                      final params = ShareParams(uri: storeUrl,
                        subject: '다시 스탠드와 함께 균형잡힌 시각을 기르세요!',
                      );
                      SharePlus.instance.share(params);
                    },
                  ),
                  SizedBox(height: MyPaddings.medium),
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
                            if(!state.isGuestLogin) BigButtonSkeleton(),
                            if(!state.isGuestLogin) SizedBox(height: MyPaddings.medium),
                            BigButtonSkeleton(),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            if(!state.isGuestLogin) BigButton(
                              '로그아웃',
                              onPressed: () async {
                                await viewModel.signOut();
                                if(context.mounted) context.go(RouteNames.root);
                              },
                            ),
                            if(!state.isGuestLogin) SizedBox(height: MyPaddings.medium),
                            BigButton(
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
      ),
    );
  }
}
