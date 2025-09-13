import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';

class CenterTitleAppBar extends StatelessWidget {
  const CenterTitleAppBar({super.key,
    this.prefix,
    required this.title,
    this.action,
  });

  final Widget? prefix;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: double.infinity,
      color: AppColors.white,
      child: Row(
        children: [
          const SizedBox(width: MyPaddings.large,),
          if (prefix != null) prefix!,
          Spacer(),
          MyText.h2(title, fontWeight: FontWeight.w400),
          Spacer(),
          if (action != null) action!,
          const SizedBox(width: MyPaddings.large,),
        ],
      ),
    );
  }
}
