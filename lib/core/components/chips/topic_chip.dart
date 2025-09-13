import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';

class TopicChip extends StatelessWidget {
  const TopicChip({super.key, this.padding, required this.title, required this.isActive, required this.onTap});
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding ?? MyPaddings.small),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Ink(
          height: 48,
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.medium,
            vertical: MyPaddings.extraSmall,
          ),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isActive ? Colors.transparent : AppColors.border,
              width: 1,
            ),
          ),
          child: Center(
            child: MyText.reg(
              title,
              color: isActive ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
