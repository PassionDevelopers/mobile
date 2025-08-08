import 'dart:io';
import 'package:could_be/core/components/buttons/login_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_button/constants.dart';
import '../../ui/color.dart';
import '../../core/analytics/unified_analytics_helper.dart';
import '../../core/analytics/analytics_event_names.dart';
import '../../core/analytics/analytics_parameter_keys.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<LoginViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final state = viewModel.state;
            return state.isLoginInProgress
                ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
                : Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: MyPaddings.extraLarge),
                        child: GestureDetector(
                          onTap: () {
                            context.push(RouteNames.settings);
                          },
                          child: Icon(
                            Icons.settings,
                            size: 30,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        MyText.h2(
                          '정식 사용자로 로그인하고',
                          color: AppColors.primaryLight,
                        ),
                        MyText.h2(
                          '모든 기능을 이용해보세요!',
                          color: AppColors.primaryLight,
                        ),
                        SizedBox(height: MyPaddings.medium),
                        LoginButton(
                          buttonType: ButtonType.googleDark,
                          onPressed: () async {
                            UnifiedAnalyticsHelper.logEvent(
                              name: AnalyticsEventNames.authTapGoogleLogin,
                              parameters: {
                                AnalyticsParameterKeys.success: 'true',
                              },
                            );
                            await viewModel.signIn(
                              context,
                              signInMethod: SignInMethod.google,
                            );
                            onLoginSuccess();
                          },
                        ),
                        if (kIsWeb || Platform.isIOS)
                          LoginButton(
                            buttonType: ButtonType.appleDark,
                            onPressed: () async {
                              UnifiedAnalyticsHelper.logEvent(
                                name: AnalyticsEventNames.authTapAppleLogin,
                                parameters: {
                                  AnalyticsParameterKeys.success: 'true',
                                },
                              );
                              await viewModel.signIn(
                                context,
                                signInMethod: SignInMethod.apple,
                              );
                              onLoginSuccess();
                            },
                          ),
                        LoginButton(
                          buttonType: ButtonType.amazon,
                          onPressed: () async {
                            UnifiedAnalyticsHelper.logEvent(
                              name: AnalyticsEventNames.authTapKakaoLogin,
                              parameters: {
                                AnalyticsParameterKeys.success: 'true',
                              },
                            );
                            await viewModel.signIn(
                              context,
                              signInMethod: SignInMethod.kakao,
                            );
                            onLoginSuccess();
                          },
                        ),
                        // LoginButton(
                        //   buttonType: ButtonType.mail,
                        //   onPressed: () async {
                        //
                        //   },
                        // ),

                        // TextButton(onPressed: ()async{
                        //   await viewModel.signIn(context, signInMethod: SignInMethod.anonymous);
                        // }, child: Text('로그인 없이 앱 사용하기', style: GoogleFonts.notoSansKr(
                        //     color: Colors.blue,
                        //     fontSize: 16,
                        //     decoration: TextDecoration.underline,
                        //     decorationColor: Colors.blue,
                        //     decorationStyle: TextDecorationStyle.solid
                        // ),),)
                      ],
                    ),
                  ],
                );
          },
        ),
      ],
    );
  }
}
