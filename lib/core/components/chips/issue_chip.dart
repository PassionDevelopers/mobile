import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';

class IssueChip extends StatelessWidget {
  const IssueChip({super.key, required this.title, required this.isActive, required this.onTap, this.padding});
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding ?? MyPaddings.small),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          child: Ink(
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
      ),
    );
  }
}
