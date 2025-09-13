import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'basic_skeleton.dart';

class NewsCardSkeleton extends StatelessWidget {
  const NewsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            BasicSkeleton(height: double.infinity, width: 83, borderRadius: BorderRadius.circular(6),),
            const SizedBox(width: MyPaddings.large,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicSkeleton(height: 14, width: 300, borderRadius: BorderRadius.circular(6),),
                  const SizedBox(height: 8,),
                  BasicSkeleton(height: 14, width: 100, borderRadius: BorderRadius.circular(6),),
                  Spacer(),
                  BasicSkeleton(height: 10, width: 100, borderRadius: BorderRadius.circular(6),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
