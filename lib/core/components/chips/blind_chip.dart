import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:flutter/cupertino.dart';

import '../../../ui/color.dart';
import '../../many_use.dart';
import '../bias/bias_enum.dart';

class BlindChip extends StatelessWidget {
  const BlindChip({super.key, required this.bias});
  final Bias bias;

  @override
  Widget build(BuildContext context) {
    Color primary = bias == Bias.center? AppColors.primary : getBiasColor(bias);
    Color secondary = primary.withAlpha(80);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary),
      ),
      child: autoSizeText(bias == Bias.center? '심한 대립' : '사각지대',
        color: primary,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// blind spot, 의견 대립,