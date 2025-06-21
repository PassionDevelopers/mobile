

import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class LabelIconButton extends StatelessWidget {
  const LabelIconButton({super.key, required this.iconData, required this.label, this.color});
  final IconData iconData;
  final Color? color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event
      },
      child: Column(
        children: [
          Icon(
            iconData,
            size: 24,
            color: color,
          ),
          MyText.reg(label),
        ],
      ),
    );
  }
}
