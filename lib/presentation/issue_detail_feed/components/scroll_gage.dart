import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class ScrollGage extends StatelessWidget {
  const ScrollGage({super.key, required this.scrollProgress});
  final double scrollProgress;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 4,
          width: MediaQuery.of(context).size.width * scrollProgress,
          decoration: BoxDecoration(color: AppColors.primary),
        ),
      ),
    );
  }
}
