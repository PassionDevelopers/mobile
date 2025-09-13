import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class RegAppBar extends StatelessWidget {
  const RegAppBar({
    super.key,
    this.iconData,
    required this.title,
    this.actions,
  });

  final IconData? iconData;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          Icon(iconData, size: 24),
          MyText.h2(title, fontWeight: FontWeight.w400),
          Spacer(),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}