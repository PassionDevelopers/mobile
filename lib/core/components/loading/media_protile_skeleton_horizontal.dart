import 'package:could_be/core/components/loading/basic_skeleton.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediaProfileSkeletonHorizontal extends StatelessWidget {
  const MediaProfileSkeletonHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: AppColors.gray300,
          borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              BasicSkeleton(height: 40, width: 40,),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  BasicSkeleton(height: 12, width: 36,),
                  BasicSkeleton(height: 12, width: 28,),
                ],
              ),
            ],
          ),
          Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                shape: BoxShape.circle,
              ),
          ),
        ],
      )),
    );
  }
}
