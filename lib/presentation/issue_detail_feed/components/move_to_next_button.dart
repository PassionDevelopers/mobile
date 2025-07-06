import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/margins_paddings.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class MoveToNextButton extends StatelessWidget {
  const MoveToNextButton({super.key, required this.moveToNextPage, required this.buttonText});
  final VoidCallback moveToNextPage;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: moveToNextPage,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: MyPaddings.large),
        child: Shimmer.fromColors(
          baseColor: AppColors.gray2,
          highlightColor: AppColors.gray4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_double_arrow_down_rounded, color: AppColors.gray2),
              SizedBox(width: MyPaddings.small),
              MyText.h3(buttonText, color: AppColors.gray2),
            ],
          ),
        ),
      ),
    );
  }
}
