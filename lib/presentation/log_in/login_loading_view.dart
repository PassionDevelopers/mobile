import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

class LoginLoadingView extends StatelessWidget {
  const LoginLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        insetPadding: EdgeInsets.zero,
        backgroundColor:AppColors.primary.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryLight,
            strokeWidth: 4.0,
          ),
        ),
      ),
    );
  }
}
