import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/coverage_spectrum.dart';
import '../../themes/color.dart';
import 'bias_label.dart';

class CardBiasBar extends StatelessWidget {
  CardBiasBar({super.key, required this.coverageSpectrum, this.isDailyIssue = false});
  final CoverageSpectrum coverageSpectrum;
  final bool isDailyIssue;

  final AutoSizeGroup titleGroup = AutoSizeGroup();

  Widget _buildBiasLabel({required CoverageSpectrum coverageSpectrum}) {
    return Row(
      children: [
        Expanded(child: BiasLabel(group: titleGroup, label: '진보 언론 ${coverageSpectrum.left + coverageSpectrum.centerLeft}개', color: getBiasColor(Bias.left),)),
        SizedBox(width: 12),
        Expanded(child: BiasLabel(group: titleGroup, label: '중도 언론 ${coverageSpectrum.center}개', color: getBiasColor(Bias.center),)),
        SizedBox(width: 12),
        Expanded(child: BiasLabel(group: titleGroup, label: '보수 언론 ${coverageSpectrum.centerRight + coverageSpectrum.right}개', color: getBiasColor(Bias.right),)),
      ],
    );
  }
  LinearGradient _buildSmoothBiasGradient(int total) {
    // 각 영역의 비율 계산
    double leftRatio = (coverageSpectrum.left + coverageSpectrum.centerLeft) / total;
    double centerRatio = coverageSpectrum.center / total;
    // 부드러운 블렌딩을 위한 transition zone (전체의 1.5%)
    double transition = 0.03;
    
    // 각 영역의 시작과 끝 지점 계산
    double leftEnd = leftRatio;
    double centerStart = leftRatio;
    double centerEnd = leftRatio + centerRatio;
    double rightStart = centerEnd;
    
    return LinearGradient(
      stops: [
        // 0.0,                                    // 진보 영역 시작
        // (leftEnd - transition),  // 진보 영역 끝 (순수 색상)
        // (centerStart + transition), // 중도 영역 시작 (블렌딩 후)
        // // ((centerStart + transition) + (centerEnd - transition))/2 ,
        // (centerEnd - transition),  // 중도 영역 끝 (순수 색상)
        // (rightStart + transition),  // 보수 영역 시작 (블렌딩 후)
        // 1.0,                                    // 보수 영역 끝
        0.0,                                    // 진보 영역 시작
        leftEnd,
        centerStart,
        centerEnd,
        rightStart,
        1.0,                                    // 보수 영역 끝
      ],
      colors: [
        AppColors.left.withOpacity(0.6),
        AppColors.left.withOpacity(0.6),  // 진보 영역 끝 (블렌딩 후)
        // 진보 시작
        // AppColors.leftCenter,
        AppColors.center.withOpacity(0.6),
        AppColors.center.withOpacity(0.6),
        AppColors.right.withOpacity(0.6),         // 보수 시작 (블렌딩 후)
        AppColors.right.withOpacity(0.6),         // 보수 끝
      ],
      // begin: Alignment.centerLeft,
      // end: Alignment.centerRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = coverageSpectrum.left +
        coverageSpectrum.centerLeft +
        coverageSpectrum.center +
        coverageSpectrum.centerRight +
        coverageSpectrum.right;
    
    // total이 0인 경우 기본 gradient 사용
    if (total == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBiasLabel(coverageSpectrum: coverageSpectrum),
          SizedBox(height: 4),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.grey.shade200,
            ),
          ),
        ],
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isDailyIssue? _buildBiasLabel(coverageSpectrum: coverageSpectrum) : SizedBox(),
        SizedBox(height: isDailyIssue? 4 : 0),
        Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: _buildSmoothBiasGradient(total),
          ),
        ),
      ],
    );
  }
}