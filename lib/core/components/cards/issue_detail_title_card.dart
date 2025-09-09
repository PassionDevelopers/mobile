import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

class IssueDetailTitleCard extends StatelessWidget {
  const IssueDetailTitleCard({
    super.key,
    required this.icon,
    required this.title,
  });

  final Widget icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MyPaddings.medium),
      child: Container(
        padding: EdgeInsets.all(MyPaddings.medium),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // BackButton(),
            icon,
            SizedBox(width: MyPaddings.medium),
            title,
          ],
        ),
      ),
    );
  }
}
