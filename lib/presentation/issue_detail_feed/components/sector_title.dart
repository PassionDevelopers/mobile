import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';

class SectorTitle extends StatelessWidget {
  const SectorTitle({super.key, required this.title, required this.icon, required this.onTap, required this.isSpread});
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSpread;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
            SizedBox(width: MyPaddings.medium),
            MyText.h3(title, ),
            Spacer(),
            Icon(
              isSpread ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}

