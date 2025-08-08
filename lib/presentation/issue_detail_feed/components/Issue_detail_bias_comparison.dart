import 'dart:developer';

import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/cards/issue_detail_title_card.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
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
    required this.moveToNextPage,
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
  final VoidCallback moveToNextPage;
  final bool isSpread;
  final VoidCallback spreadCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: spreadCallback,
            child: Container(
              padding: EdgeInsets.all(MyPaddings.large),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray5,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.troubleshoot,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  SizedBox(width: MyPaddings.medium),
                  MyText.h2(
                    '보도 내용 차이점 정리',
                  ),
                  Spacer(),
                  Icon(
                    isSpread ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if(isSpread)
            Column(
              children: [
                if(leftComparison != null || centerComparison != null || rightComparison != null)
                  Padding(
                    padding: const EdgeInsets.all(MyPaddings.large),
                    child: Column(
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
                            child: Divider(color: AppColors.gray4, height: 1),
                          ),
                        if(centerComparison != null) _buildComparisonItem(
                          comparison: centerComparison!,
                          bias: Bias.center,
                          fontSize: fontSize,
                        ),
                        if(centerComparison != null && rightComparison != null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
                            child: Divider(color: AppColors.gray4, height: 1),
                          ),
                        if(rightComparison != null) _buildComparisonItem(
                          comparison: rightComparison!,
                          bias: Bias.right,
                          fontSize: fontSize,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: MyPaddings.large),
              ],
            ),
        ],
      ),
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
              style: MyFontStyle.h1.copyWith(
                color: getBiasColor(bias),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: MyPaddings.small),
        parseAiText(comparison, fontSize, AppColors.gray1, getBiasColor(bias)),
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
