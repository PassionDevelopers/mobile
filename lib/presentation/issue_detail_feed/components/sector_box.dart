import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';

class SectorBox extends StatelessWidget {
  const SectorBox({super.key, required this.content});
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.large),
        color: AppColors.white,
        child: content
      ),
    );
  }
}
