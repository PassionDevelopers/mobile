import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../themes/margins_paddings.dart';

class LabelIconButton extends StatelessWidget {
  const LabelIconButton({
    super.key,
    required this.iconData,
    required this.label,
    this.color,
    required this.onTap,
  });

  final IconData iconData;
  final Color? color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(MyPaddings.medium),
          child: Column(
            children: [
              Icon(iconData, size: 24, color: color ?? AppColors.gray1),
              MyText.reg(label, color: AppColors.gray1),
            ],
          ),
        ),
      ),
    );
  }
}
