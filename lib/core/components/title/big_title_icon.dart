import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../../ui/fonts.dart';

class BigTitleAdd extends StatelessWidget {
  const BigTitleAdd({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText.h1(title),
          const SizedBox(width: 8),
          Icon(Icons.add_circle,
            size: 24,
            color: AppColors.primary
          ),
        ],
      ),
    );
  }
}
