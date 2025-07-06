import 'package:could_be/core/components/loading/chip_skeleton.dart';
import 'package:flutter/material.dart';

import '../../themes/margins_paddings.dart';

class ChipLoadingView extends StatelessWidget {
  const ChipLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ChipSkeleton(isFirst: index == 0);
          },
        ),
      ),
    );
  }
}
