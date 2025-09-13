import 'package:could_be/core/components/loading/basic_skeleton.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediaProfileSkeletonVertical extends StatelessWidget {
  const MediaProfileSkeletonVertical({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.gray300,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              BasicSkeleton(width: 40, height: 40,),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  BasicSkeleton(width: 36, height: 12,),
                  BasicSkeleton(width: 28, height: 12,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
