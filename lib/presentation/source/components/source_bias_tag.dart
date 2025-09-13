import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class SourceBiasTag extends StatelessWidget {
  const SourceBiasTag({super.key, required this.bias});
  final Bias bias;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: ShapeDecoration(
        color: getBiasBackgroundColor(bias),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)),
      ),
      child: autoSizeText(
        getBiasName(bias),
        color: getBiasColor(bias),
        fontSize: 9,
        minFontSize: 1
      ),
    );
  }
}
