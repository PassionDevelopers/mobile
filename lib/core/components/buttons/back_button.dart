import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MyPaddings.small, top: MyPaddings.small,),
      decoration: BoxDecoration(
        color: AppColors.gray700.withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary,),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
