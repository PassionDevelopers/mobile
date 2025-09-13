
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_title.dart';
import 'package:flutter/material.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/themes/margins_paddings.dart';

class IssueDetailBiasComparison extends StatelessWidget {
  const IssueDetailBiasComparison({
    super.key,
    required this.leftComparison,
    required this.centerComparison,
    required this.rightComparison,
    required this.userEvaluation,
    required this.onBiasSelected,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.isEvaluating,
    required this.existLeft,
    required this.existCenter,
    required this.existRight,
    required this.fontSize,
    required this.isSpread,
    required this.spreadCallback,
  });

  final String? leftComparison;
  final String? centerComparison;
  final String? rightComparison;
  final String? userEvaluation;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final bool isEvaluating;
  final bool existLeft;
  final bool existCenter;
  final bool existRight;
  final double fontSize;
  final void Function(Bias bias) onBiasSelected;
  final bool isSpread;
  final VoidCallback spreadCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectorTitle(title: '보도 내용 차이점 정리', icon: Icons.troubleshoot, onTap:spreadCallback, isSpread: isSpread),
        if(isSpread) SizedBox(height: MyPaddings.large),
        if(isSpread)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(leftComparison != null) _buildComparisonItem(
                  comparison: leftComparison!,
                  bias: Bias.left,
                  fontSize: fontSize,
                ),
                if(leftComparison != null && (centerComparison != null || rightComparison != null))
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
                    child: Divider(color: AppColors.gray300, height: 1),
                  ),
                if(centerComparison != null) _buildComparisonItem(
                  comparison: centerComparison!,
                  bias: Bias.center,
                  fontSize: fontSize,
                ),
                if(centerComparison != null && rightComparison != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
                    child: Divider(color: AppColors.gray300, height: 1),
                  ),
                if(rightComparison != null) _buildComparisonItem(
                  comparison: rightComparison!,
                  bias: Bias.right,
                  fontSize: fontSize,
                ),
              ],
            ),
      ],
    );
  }

  Widget _buildComparisonItem({
    required String comparison,
    required Bias bias,
    required double fontSize,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 20,
              margin: EdgeInsets.only(right: MyPaddings.medium, top: 2),
              decoration: BoxDecoration(
                color: getBiasColor(bias),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              getBiasTitle(bias),
              style: MyFontStyle.h3.copyWith(
                color: getBiasColor(bias),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: MyPaddings.small),
        parseAiText(comparison, fontSize, AppColors.gray700, getBiasColor(bias)),
      ],
    );
  }

  String getBiasTitle(Bias bias) {
    switch (bias) {
      case Bias.left:
        return '진보 성향';
      case Bias.center:
        return '중도 성향';
      case Bias.right:
        return '보수 성향';
      default:
        return '';
    }
  }
}
