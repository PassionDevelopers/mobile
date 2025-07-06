import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChipSkeleton extends StatelessWidget {
  const ChipSkeleton({super.key, required this.isFirst});
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 42,
        width: 70,
        margin: EdgeInsets.only(left: isFirst? MyPaddings.largeMedium : MyPaddings.small),
        padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.medium,
          vertical: MyPaddings.extraSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
