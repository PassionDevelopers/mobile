import 'package:could_be/ui/color_styles.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import 'my_chip.dart';

class KeyWordChip extends StatelessWidget {
  const KeyWordChip({super.key, required this.title, this.color});
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MyChip(content: MyText.small(title,

    ), color: color ?? ColorStyles.gray5, borderColor: null,);
  }
}
