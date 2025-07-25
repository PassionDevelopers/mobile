
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import 'my_chip.dart';

class KeyWordChip extends StatelessWidget {
  const KeyWordChip({super.key, required this.title, this.color, this.borderColor, this.textColor});
  final String title;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return MyChip(content: MyText.small(title,
      color: textColor,
    ), color: color ?? AppColors.gray5,
      borderColor: borderColor ?? AppColors.gray5,);
  }
}
