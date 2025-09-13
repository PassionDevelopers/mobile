import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/issue/issue_tag.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/cupertino.dart';
import '../../themes/color.dart';

class BlindChip extends StatelessWidget {
  const BlindChip({super.key, required this.tag, this.topPadding, this.insetPadding});
  final IssueTag tag;
  final double? topPadding;
  final EdgeInsetsGeometry? insetPadding;

  @override
  Widget build(BuildContext context) {
    Color primary = tag.color;
    // Color secondary = primary.withAlpha(80);
    return Container(
      margin: EdgeInsets.only(
        top: topPadding ?? MyPaddings.small, right: MyPaddings.small),
      padding: insetPadding ?? EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: primary),
      ),
      child: MyText.smaller(tag.name,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// blind spot, 의견 대립,