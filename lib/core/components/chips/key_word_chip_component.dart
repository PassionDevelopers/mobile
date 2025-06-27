import 'package:could_be/ui/color_styles.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import 'my_chip.dart';

class KeyWordChip extends StatelessWidget {
  const KeyWordChip({super.key, required this.title, this.color, this.borderColor});
  final String title;
  final Color? color;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return MyChip(content: MyText.small(title,
      color: borderColor,
    ), color: color ?? ColorStyles.gray5, borderColor: borderColor ?? ColorStyles.gray5,);
  }
}
