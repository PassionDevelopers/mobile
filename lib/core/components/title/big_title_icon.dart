import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import '../../themes/fonts.dart';

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

class EmptyTitleAdd extends StatelessWidget {
  const EmptyTitleAdd({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MyPaddings.medium, horizontal: MyPaddings.largeMedium),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: myShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText.h3(title),
              const SizedBox(width: 8),
              Icon(Icons.add_circle,
                  size: 24,
                  color: AppColors.primary
              ),
            ],
          ),
        ),
      ),
    );
  }
}
