import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/custom_image.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.buttonType, required this.onPressed});
  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SignInButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: 10,
        elevation: 2,
        buttonSize: ButtonSize.medium,
        buttonType: buttonType,
        btnText: switch(buttonType) {
          ButtonType.googleDark => 'Google로 로그인',
          ButtonType.appleDark => 'Apple로 로그인',
          ButtonType.mail => 'Email로 로그인',
          ButtonType.custom => 'Guest로 로그인',
          ButtonType.amazon => 'Kakao로 로그인',
          _ => '',
        },
        btnColor: switch(buttonType) {
          ButtonType.amazon => AppColors.kakao,
          _ => null,
        },
        btnTextColor: switch(buttonType) {
          ButtonType.amazon => AppColors.kakaoText,
          _ => null,
        },
        customImage: switch(buttonType) {
          ButtonType.custom => CustomImage('assets/images/logo/app_icon2.png'),
          ButtonType.amazon => CustomImage('assets/images/login/kakao.png'),
          _ => null,
        },
        onPressed: onPressed,
      ),
    );
  }
}
