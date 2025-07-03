import 'package:flutter/material.dart';

import '../../method/bias/bias_method.dart';
import '../../themes/margins_paddings.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, required this.color, required this.child});
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: MyPaddings.medium,
        vertical: MyPaddings.medium,
      ),
      child: SingleChildScrollView(child: child),
    );
  }
}
