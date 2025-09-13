import 'dart:developer';

import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/source/components/media_profile_component.dart';
import 'package:flutter/material.dart';

class SourceEvaluateCard extends StatelessWidget {
  const SourceEvaluateCard({super.key,
    this.source,
    required this.userEvaluatedPerspective,
    required this.onBiasSelected,
  });

  final Source? source;
  final String? userEvaluatedPerspective;
  final Function(String perspective) onBiasSelected;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium, vertical: MyPaddings.small),
      child: Ink(
        padding: EdgeInsets.all(MyPaddings.medium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: myShadow
        ),
        height: 150,
        child: Column(
          children: [
            if(source != null) Row(
              children: [
                MediaProfileWebView(source: source!, isShowingArticles: false),
                MyText.h3(source!.name)
              ],
            ),
            Expanded(
              child: SourceEvaluationRow(
                userEvaluatedPerspective: userEvaluatedPerspective,
                onBiasSelected: onBiasSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceEvaluationRow extends StatelessWidget {
  const SourceEvaluationRow({super.key, required this.userEvaluatedPerspective,
    required this.onBiasSelected, });

  final String? userEvaluatedPerspective;
  final Function(String perspective) onBiasSelected;

  Widget _buildBiasOption(Bias bias) {
    final isSelected = userEvaluatedPerspective == bias.toPerspective();
    log('userEvaluated : ${userEvaluatedPerspective.toString()},isSelected: $isSelected');

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
                color: isSelected ? getBiasBackgroundColor(bias) : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? getBiasColor(bias) : AppColors.gray400,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MyText.small(
                      getBiasName(bias),
                      color: isSelected ? getBiasColor(bias) : AppColors.gray700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: getBiasColor(bias),
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

