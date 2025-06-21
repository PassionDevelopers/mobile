import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/bias/bias_method.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../domain/entities/coverage_spectrum.dart';
import '../../../ui/color.dart';
import '../../../ui/color_styles.dart';
import '../../../ui/fonts.dart';
import 'bias_label.dart';

class CardBiasBar extends StatelessWidget {
  const CardBiasBar({super.key, required this.coverageSpectrum});
  final CoverageSpectrum coverageSpectrum;

  Widget _buildBiasLabel({required CoverageSpectrum coverageSpectrum}) {
    return Row(
      children: [
        BiasLabel(label: '진보 매체 ${coverageSpectrum.left + coverageSpectrum.centerLeft}개', color: getBiasColor(Bias.left),),
        SizedBox(width: 12),
        BiasLabel(label: '중도 매체 ${coverageSpectrum.centerLeft + coverageSpectrum.center}개', color: getBiasColor(Bias.center),),
        SizedBox(width: 12),
        BiasLabel(label: '보수 매체 ${coverageSpectrum.centerRight + coverageSpectrum.right}개', color: getBiasColor(Bias.right),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    int total = coverageSpectrum.left +
        coverageSpectrum.centerLeft +
        coverageSpectrum.center +
        coverageSpectrum.centerRight +
        coverageSpectrum.right;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBiasLabel(coverageSpectrum: coverageSpectrum),
        SizedBox(height: 4),
        GlassContainer(
          height: 10,
          borderRadius: BorderRadius.circular(24.0),
          borderWidth: 1.0,
          elevation: 3.0,
          // \isFrostedGlass: true,
          shadowColor: Colors.purple.withOpacity(0.20),
          gradient: LinearGradient(
            stops: [
              0.0,
              // (coverageSpectrum.left + coverageSpectrum.centerLeft) / total,
              //
              // // (coverageSpectrum.left + coverageSpectrum.centerLeft) / total,
              // (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center) / total,

              // (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center) / total,
              1.0,
            ],
            colors: [
              AppColors.left,
              // AppColors.left,

              // AppColors.center,
              // AppColors.center,

              // AppColors.right,
              AppColors.right,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.60),
              Colors.white.withOpacity(0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   gradient: LinearGradient(
          //     colors: [
          //       AppColors.left,
          //       AppColors.left,
          //
          //       // Color(0xff8CCDEB), Color(0xff8CCDEB),
          //
          //       // AppColors.leftCenter,
          //       // AppColors.leftCenter,
          //       // AppColors.rightCenter,
          //
          //       AppColors.center,
          //       AppColors.center,
          //
          //       // Color(0xffF28585), Color(0xffF28585),
          //
          //       // AppColors.leftCenter,
          //
          //       AppColors.right,
          //       AppColors.right,
          //     ],
          //     stops: [
          //       //left
          //       0.0,
          //       (coverageSpectrum.left + coverageSpectrum.centerLeft) / total,
          //
          //       //+1
          //       // (coverageSpectrum.left + coverageSpectrum.centerLeft) / total,
          //       // (coverageSpectrum.left + coverageSpectrum.centerLeft + 1) / total,
          //
          //       //center
          //       (coverageSpectrum.left + coverageSpectrum.centerLeft) / total,
          //       (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center) / total,
          //
          //       //+1
          //       // (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center + 1) / total,
          //       // (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center + 2) / total,
          //
          //       (coverageSpectrum.left + coverageSpectrum.centerLeft + coverageSpectrum.center) / total,
          //       1.0,
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}