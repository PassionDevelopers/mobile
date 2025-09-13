import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class IssueChip2 extends StatelessWidget {
  const IssueChip2({super.key, required this.title, required this.isActive, required this.onTap});
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColors.black : Colors.transparent,
              ),
            ),
            Center(
              child: MyText.small(
                title,
                color: isActive ? AppColors.black : AppColors.gray500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
