import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/log_in/login_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LoginPopUp extends StatelessWidget {
  const LoginPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.primaryLight,
      insetPadding: const EdgeInsets.all(15),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.h1('로그인이 필요합니다.', color: AppColors.warning),
            const SizedBox(height: 10,),
            SizedBox(
                height: 100,
                child: Center(
                  child: MyText.h3('로그인 후 다시 스탠드의 모든 기능을 이용할 수 있습니다.',
                      maxLines: 3),
                )),
            const SizedBox(height: 10,),
            Expanded(child: LoginView(
              onLoginSuccess: () {
                Navigator.of(context).pop();
              },
            ))
          ],
        ),
      ),
    );
  }
}
