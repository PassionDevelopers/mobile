import 'dart:developer';

import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_enum.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/themes/margins_paddings.dart';

class IssueDetailBiasComparison extends StatelessWidget {
  const IssueDetailBiasComparison({
    super.key,
    required this.biasComparison,
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
  });

  final String biasComparison;
  final String? userEvaluation;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final bool isEvaluating;
  final bool existLeft;
  final bool existCenter;
  final bool existRight;
  final void Function(Bias bias) onBiasSelected;
  final VoidCallback moveToNextPage;

  _buildBiasCircle(Bias bias) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.small,
        vertical: MyPaddings.small,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (!isEvaluating) onBiasSelected(bias);
        },
        child: Ink(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: getBiasColor(bias)),
          ),
          child: Center(child: Icon(Icons.check, color: getBiasColor(bias))),
        ),
      ),
    );
  }

  _buildBiasRect(Bias bias) {
    int total = leftLikeCount + centerLikeCount + rightLikeCount;
    bool isSelected = userEvaluation == bias.toPerspective();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.small,
        vertical: MyPaddings.small,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (!isEvaluating) onBiasSelected(bias);
        },
        child: Ink(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [
                0,
                switch (bias) {
                  Bias.left => leftLikeCount / total,
                  Bias.center => centerLikeCount / total,
                  _ => rightLikeCount / total,
                },
                switch (bias) {
                  Bias.left => leftLikeCount / total,
                  Bias.center => centerLikeCount / total,
                  _ => rightLikeCount / total,
                },
                1.0,
              ],
              colors: [
                getBiasColor(bias).withOpacity(0.2),
                getBiasColor(bias).withOpacity(0.2),
                AppColors.primaryLight,
                AppColors.primaryLight,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? getBiasColor(bias) : AppColors.gray3,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: isSelected ? getBiasColor(bias) : AppColors.gray3,
              ),
              SizedBox(width: MyPaddings.small),
              MyText.reg(switch (bias) {
                Bias.left => leftLikeCount.toString(),
                Bias.right => rightLikeCount.toString(),
                _ => centerLikeCount.toString(),
              }, color: isSelected ? getBiasColor(bias) : AppColors.gray3),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [BackButton(), BigTitle(title: '언론 성향별 차이점')]),
        SizedBox(height: MyPaddings.medium),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
            child: Column(
              children: [
                Expanded(
                  child: TextCard(
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String para in parseAiText(biasComparison)) ...[
                            MyText.article('• $para', color: AppColors.gray2),
                            SizedBox(height: MyPaddings.small),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                  ),
                  child: BiasCheckButton(
                    userEvaluation: userEvaluation,
                    onBiasSelected: onBiasSelected,
                    leftLikeCount: leftLikeCount,
                    centerLikeCount: centerLikeCount,
                    rightLikeCount: rightLikeCount,
                    isEvaluating: isEvaluating,
                    existLeft: existLeft,
                    existCenter: existCenter,
                    existRight: existRight,
                  ),
                ),
                MoveToNextButton(
                  moveToNextPage: moveToNextPage,
                  buttonText: '언론의 원문 기사 보기',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
