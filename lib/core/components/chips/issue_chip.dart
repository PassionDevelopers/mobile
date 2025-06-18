import 'package:flutter/material.dart';

import '../../../presentation/themes/margins_paddings.dart';
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
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
            padding: EdgeInsets.symmetric(horizontal: MyPaddings.small, vertical: MyPaddings.extraSmall),
            decoration: BoxDecoration(
              color: isActive? AppColors.primary : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: MyText.h3(title, color: isActive? AppColors.textPrimaryLight : AppColors.textPrimary))
        ),
      ),
    );
  }
}
