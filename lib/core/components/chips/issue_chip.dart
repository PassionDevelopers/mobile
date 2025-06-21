import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class IssueChip extends StatelessWidget {
  const IssueChip({super.key, required this.title, required this.isActive, required this.onTap});
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MyPaddings.small),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MyPaddings.medium,
              vertical: MyPaddings.small,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isActive ? Colors.transparent : AppColors.border,
                width: 1,
              ),
            ),
            child: Center(
              child: MyText.h3(
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
