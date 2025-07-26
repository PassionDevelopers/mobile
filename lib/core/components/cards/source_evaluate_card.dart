import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class SourceEvaluateCard extends StatelessWidget {
  const SourceEvaluateCard({super.key,
    required this.userEvaluatedPerspective,
    required this.onBiasSelected,
  });

  final String? userEvaluatedPerspective;
  final Function(String perspective) onBiasSelected;

  Widget _buildBiasOption(Bias bias) {
    final isSelected = userEvaluatedPerspective ==
        bias.toPerspective();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: InkWell(
          onTap: () {
            onBiasSelected(bias.toPerspective());
          },
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1,
            child: Ink(
              decoration: BoxDecoration(
                color: isSelected ? getBiasColor(bias) : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? getBiasColor(bias) : AppColors.gray4,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MyText.small(
                      getBiasName(bias),
                      color: isSelected ? AppColors.white : AppColors.gray2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.white : getBiasColor(bias),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final biasOptions = [
      Bias.left,
      Bias.leftCenter,
      Bias.center,
      Bias.rightCenter,
      Bias.right,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: biasOptions.map((bias) =>
          _buildBiasOption(bias)
      ).toList(),
    );
  }
}
