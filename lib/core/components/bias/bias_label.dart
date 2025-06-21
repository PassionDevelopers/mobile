import 'package:flutter/material.dart';
import '../../../ui/color_styles.dart';
import '../../../ui/fonts.dart';
import '../../../presentation/media/media_components.dart';
import 'bias_enum.dart';

class BiasLabel extends StatelessWidget {
  const BiasLabel({super.key, required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
