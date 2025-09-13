import 'dart:io';
import 'package:could_be/core/components/buttons/login_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_button/constants.dart';
import '../../core/themes/color.dart';
import '../../core/analytics/unified_analytics_helper.dart';

class LoginPopUp extends StatelessWidget {
  const LoginPopUp({super.key, this.isMyPage = false});
  final bool isMyPage;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<LoginViewModel>();
    return SafeArea(
      child: Container(
        margin: isMyPage? EdgeInsets.symmetric(
          horizontal: MyPaddings.large,
        ) : null,
        padding: EdgeInsets.all(MyPaddings.large),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: isMyPage? BorderRadius.circular(20) :
            BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray500.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final state = viewModel.state;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText.h2(
                  '정식 사용자로 로그인하고',
                  color: AppColors.primary,
                ),
                MyText.h2(
                  '모든 기능을 이용해보세요!',
                  color: AppColors.primary,
                ),
                SizedBox(height: MyPaddings.large),
                LoginButton(
                  buttonType: ButtonType.googleDark,
                  onPressed: () async {
                    UnifiedAnalyticsHelper.logAuthEvent(
                      method: 'google',
                      success: true,
                    );
                    await viewModel.signIn(
                      context,
                      signInMethod: SignInMethod.google,
                    );
                  },
                ),
                if (kIsWeb || Platform.isIOS)
                  LoginButton(
                    buttonType: ButtonType.appleDark,
                    onPressed: () async {
                      UnifiedAnalyticsHelper.logAuthEvent(
                        method: 'apple',
                        success: true,
                      );
                      await viewModel.signIn(
                        context,
                        signInMethod: SignInMethod.apple,
                      );
                    },
                  ),
                LoginButton(
                  buttonType: ButtonType.amazon,
                  onPressed: () async {
                    UnifiedAnalyticsHelper.logAuthEvent(
                      method: 'kakao',
                      success: true,
                    );
                    await viewModel.signIn(
                      context,
                      signInMethod: SignInMethod.kakao,
                    );
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
            );
          },
        ),
      ),
    );
  }
}
