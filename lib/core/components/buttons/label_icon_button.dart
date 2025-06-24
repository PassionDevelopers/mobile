import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [Icon(iconData, size: 24, color: color), MyText.reg(label)],
      ),
    );
  }
}
