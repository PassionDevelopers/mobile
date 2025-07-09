import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/buttons/login_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/constants.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key, required this.onDeleteAccount, });
  final void Function(BuildContext context) onDeleteAccount;
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
              MyText.h1('계정 삭제', color: AppColors.warning),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                  child: Center(
                    child: MyText.h3('계정을 삭제하면 모든 데이터가 영구적으로 삭제됩니다. 계정 삭제를 원하시면 아래 버튼을 눌러주세요.',
                    maxLines: 3),
                  )),
              const SizedBox(height: 10,),
              BigButton('계정 삭제', backgroundColor: AppColors.warning,
                  onPressed: (){
                onDeleteAccount(context);
              })
            ],
          ),
        ),
    );
  }
}