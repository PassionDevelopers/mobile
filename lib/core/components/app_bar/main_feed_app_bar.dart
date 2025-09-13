import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class MainFeedAppBar extends StatelessWidget {
  const MainFeedAppBar({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

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
            SizedBox(
              width: 100,
                child: Image.asset('assets/images/logo/main_feed.png', fit: BoxFit.fitWidth,)),
            Spacer(),
            Icon(Icons.search, color: AppColors.gray700,),
            SizedBox(width: 16),
            Icon(Icons.alarm, color: AppColors.gray700,),
          ],
        ),
      ),
    );
  }
}
