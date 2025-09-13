import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BasicSkeleton extends StatelessWidget {
  const BasicSkeleton({super.key, this.height = double.infinity, this.width = double.infinity, this.borderRadius});

  final double height;
  final double width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.gray600,
          borderRadius: borderRadius ?? BorderRadius.circular(6),
        ),
      ),
    );
  }
}
