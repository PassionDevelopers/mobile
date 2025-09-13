import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class SubscribeAppBar extends StatelessWidget {
  const SubscribeAppBar({
    super.key,
    required this.title,
    required this.count,
    required this.onPressed,
    required this.iconData,
  });

  final String title;
  final int count;
  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 85,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(iconData, size: 24),
            MyText.h2(title, fontWeight: FontWeight.w400),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: ShapeDecoration(
                color: AppColors.gray50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [MyText.small('$count개')],
              ),
            ),
            Spacer(),
            Icon(Icons.add, color: AppColors.gray700,)
          ],
        ),
      ),
    );
  }
}
