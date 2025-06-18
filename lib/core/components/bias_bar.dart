import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../domain/models/coverage_spectrum_model.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';

class CardBiasBar extends StatelessWidget {
  const CardBiasBar({super.key, required this.coverageSpectrum});
  final CoverageSpectrumModel coverageSpectrum;

  Widget _buildBiasLabel({required CoverageSpectrumModel coverageSpectrum}) {
    return Row(
      children: [
        _buildDistributionLabel('진보 매체', AppColors.left, coverageSpectrum.left),
        SizedBox(width: 12),
        _buildDistributionLabel('중도 매체', AppColors.center, coverageSpectrum.center),
        SizedBox(width: 12),
        _buildDistributionLabel('보수 매체', AppColors.right, coverageSpectrum.right),
      ],
    );
  }

  Widget _buildDistributionLabel(String label, Color color, int percentage) {
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
          Expanded(child: MyText.reg('$label $percentage개', color: AppColors.textSecondary))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    int total = coverageSpectrum.left +
        coverageSpectrum.centerLeft +
        coverageSpectrum.center +
        coverageSpectrum.centerRight +
        coverageSpectrum.right + 4;
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
            colors: [
              AppColors.left,
              AppColors.left,

              AppColors.center,
              AppColors.center,

              AppColors.right,
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