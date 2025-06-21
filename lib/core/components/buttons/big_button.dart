import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const BigButton(
      this.text, {
        super.key,
        required this.onPressed,
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
          color: AppColors.primaryLight
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.h3(text, ),
            const SizedBox(width: 11),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}