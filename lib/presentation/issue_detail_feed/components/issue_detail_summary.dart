import 'package:could_be/core/components/buttons/back_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../../core/components/bias/bias_bar.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import '../../../ui/fonts.dart';
import 'header.dart';

class IssueDetailSummary extends StatelessWidget {
  const IssueDetailSummary({
    super.key,
    required this.issue,
    required this.fontSize,
    required this.moveToNextPage,
  });

  final IssueDetail issue;
  final double fontSize;
  final VoidCallback moveToNextPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            issue.imageUrl != null
                ? ImageContainer(
                  height: 200,
                  imageUrl: issue.imageUrl,
                  borderRadius: BorderRadius.zero,
                )
                : SizedBox(height: MyPaddings.small,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IssueDetailHeader(issue: issue),
                    SizedBox(height: MyPaddings.small),
                    CardBiasBar(
                      coverageSpectrum: issue.coverageSpectrum,
                      isDailyIssue: true,
                    ),
                    SizedBox(height: MyPaddings.small),
                    Expanded(
                      child: TextCard(
                        color: AppColors.gray1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (String para in parseAiText(issue.summary))
                                Text(
                                  para,
                                  style: TextStyle(
                                    fontSize: fontSize.toDouble(),
                                    color: AppColors.gray1,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                // MyText.article(para, color: AppColors.gray1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
              child: MoveToNextButton(
                moveToNextPage: moveToNextPage,
                buttonText: '성향별 보도 내용 보기',
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: MyBackButton()
        ),
      ],
    );
  }
}
