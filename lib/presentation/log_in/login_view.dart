import 'dart:developer';
import 'dart:io';
import 'package:could_be/core/components/buttons/login_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/constants.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../ui/color.dart';

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
        // Container(
        //   height: 100,
        //   margin: const EdgeInsets.only(bottom: 30),
        //   child: Image.asset('assets/images/logo/logo_rect.png'),
        // ),
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
                MyText.h2(
                  '정식 사용자로 로그인하고', color: AppColors.primaryLight,
                ),
                MyText.h2(
                  '나의 성향을 확인해보세요', color: AppColors.primaryLight,
                ),
                SizedBox(height: MyPaddings.medium),
                LoginButton(
                  buttonType: ButtonType.googleDark,
                  onPressed: () async {
                    await viewModel.signIn(context, signInMethod: SignInMethod.google);
                    onLoginSuccess();
                  },
                ),
                if(kIsWeb || Platform.isIOS) LoginButton(
                  buttonType: ButtonType.appleDark,
                  onPressed: () async {
                    await viewModel.signIn(context, signInMethod: SignInMethod.apple);
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
            );
          },
        ),
      ],
    );
  }
}
