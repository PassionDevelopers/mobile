import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function() onPressed;

  const BigButton(
      this.text, {
        super.key,
        required this.onPressed,
        this.backgroundColor,
        this.textColor,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor ?? AppColors.primaryLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.gray4,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.h3(text, color: textColor ?? AppColors.primary,),
            const SizedBox(width: 11),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
              color: textColor ?? AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}