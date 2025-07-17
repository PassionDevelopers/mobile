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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(children: [BackButton(), BigTitle(title: '차이점 정리')]),
        IssueDetailTitleCard(
          icon: Icon(Icons.troubleshoot),
          title: BigTitle(title: '보도 내용 차이점 정리'),
        ),
        SizedBox(height: MyPaddings.medium),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Column(
            children: [
              TextCard(
                color: AppColors.primary,
                child: Column(
                  children: [
                    if(leftComparison != null) parseAiText(leftComparison!, fontSize, getBiasColor(Bias.left)),
                    if(leftComparison != null && centerComparison != null) Text('', style: TextStyle(fontSize: fontSize)),
                    if(centerComparison != null) parseAiText(centerComparison!, fontSize, getBiasColor(Bias.center)),
                    if(centerComparison != null && rightComparison != null) Text('', style: TextStyle(fontSize: fontSize)),
                    if(rightComparison != null) parseAiText(rightComparison!, fontSize, getBiasColor(Bias.right)),
                  ],
                )
              ),
              SizedBox(height: MyPaddings.medium),
              BiasCheckButton(
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
              // MoveToNextButton(
              //   moveToNextPage: moveToNextPage,
              //   buttonText: '언론의 원문 기사 보기',
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
