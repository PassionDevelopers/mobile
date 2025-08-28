import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({super.key, this.size = 100});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: size,
      color: AppColors.gray2,
    );
  }
}
