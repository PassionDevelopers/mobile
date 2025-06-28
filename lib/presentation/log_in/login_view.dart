import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../../core/components/layouts/scaffold_layout.dart';
import '../../ui/color.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.onLoginSuccess});
  final VoidCallback onLoginSuccess;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  bool isSigningIn = false;

  Widget button(
      // Future<UserCredential> Function() signInFunction,
      ButtonType buttonType){
    return SignInButton(
      buttonType: buttonType,
      onPressed: ()async{
        setState(() {
          isSigningIn = true;
        });
        var loginViewModel = LoginViewModel();
        await loginViewModel.signInWithGoogle().catchError((error){
          setState(() {
            isSigningIn = false;
          });
        });
        widget.onLoginSuccess();
        // await signInFunction().catchError((error){
        //   setState(() {
        //     isSigningIn = false;
        //   });
        // });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showAppBar: false,
        backgroundColor: AppColors.primaryLight,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.primaryLight
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/images/logo/logo_rect.png'),
                  ),
                  isSigningIn? const Center(child: CircularProgressIndicator(color: AbpColor.c1,)) : Column(children: [
                    button(
                        // signInWithGoogle,
                        ButtonType.googleDark),
                    // Platform.isIOS? button(
                    //     // signInWithApple,
                    //     ButtonType.apple) : const SizedBox(),
                    button(ButtonType.appleDark),
                    // button(ButtonType.custom),
                    button(ButtonType.mail)
                    // SignInButton(
                    //   buttonType: ButtonType.mail,
                    //   onPressed: () {
                    //     // Get.to(() => const EmailLoginPage());
                    //   },
                    // )
                  ],)
                ],
              ),
            ),
          ),
        ),
    );
  }
}
