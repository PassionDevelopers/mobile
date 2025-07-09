import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../ui/color_styles.dart';
import '../../../ui/fonts.dart';
import '../../../presentation/media/media_components.dart';
import 'bias_enum.dart';

class BiasLabel extends StatelessWidget {
  const BiasLabel({
    super.key,
    required this.color,
    required this.label,
    this.group,
    this.labelColor,
    this.mainAxisAlignment,
  });

  final Color color;
  final Color? labelColor;
  final String label;
  final AutoSizeGroup? group;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Expanded(child: MyText.reg(label, color: labelColor ?? ColorStyles.gray1, group: group)),
      ],
    );
  }
}
