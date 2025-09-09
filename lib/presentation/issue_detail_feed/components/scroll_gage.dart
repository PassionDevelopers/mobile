import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

class ScrollGage extends StatelessWidget {
  const ScrollGage({super.key, required this.scrollProgress});
  final double scrollProgress;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.gray5,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: 3,
          width: MediaQuery.of(context).size.width * scrollProgress,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.left.withOpacity(0.8),
                AppColors.center.withOpacity(0.8),
                AppColors.right.withOpacity(0.8),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}
