import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class ProfileFrame extends StatelessWidget {
  const ProfileFrame({super.key, required this.width, required this.child, });
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLight, width: 2),
        shape: BoxShape.circle,
        color: AppColors.gray5,
      ),
      child: ClipOval(child: child),
    );
  }
}
