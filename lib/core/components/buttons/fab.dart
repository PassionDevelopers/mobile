import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../themes/margins_paddings.dart';

class MyFab extends StatelessWidget {
  const MyFab({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      child: InkWell(
        child: Ink(
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.tertiary.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(MyPaddings.medium),
            child: MyText.h3(title)
          ),
        ),
      ),
    );
  }
}
