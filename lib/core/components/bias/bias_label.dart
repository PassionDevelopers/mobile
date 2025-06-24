import 'package:flutter/material.dart';
import '../../../ui/color_styles.dart';
import '../../../ui/fonts.dart';
import '../../../presentation/media/media_components.dart';
import 'bias_enum.dart';

class BiasLabel extends StatelessWidget {
  const BiasLabel({super.key, required this.color, required this.label, this.mainAxisAlignment});
  final Color color;
  final String label;
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
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Expanded(child: MyText.reg(label, color:  ColorStyles.gray1))
      ],
    );
  }
}
