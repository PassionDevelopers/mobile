import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../../core/components/bias/bias_bar.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import '../../../ui/fonts.dart';
import 'header.dart';

class IssueDetailSummary extends StatelessWidget {
  const IssueDetailSummary({super.key, required this.issue});
  final IssueDetail issue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        issue.imageUrl != null
            ?
        ImageContainer(height: 200, imageUrl: issue.imageUrl!, borderRadius: BorderRadius.zero,)
            : SizedBox(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IssueDetailHeader(issue: issue),
                SizedBox(height: MyPaddings.medium),
                CardBiasBar(
                  coverageSpectrum: issue.coverageSpectrum,
                  isDailyIssue: true,
                ),
                SizedBox(height: MyPaddings.medium),
                MyText.article(issue.summary, color: AppColors.gray2),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard_double_arrow_down_rounded, color: AppColors.gray2),
            SizedBox(width: MyPaddings.small),
            MyText.reg('성향별 보도 내용을 확인하세요.', color: AppColors.gray2),
          ],
        ),
        SizedBox(height: MyPaddings.medium),
      ],
    );
  }
}
