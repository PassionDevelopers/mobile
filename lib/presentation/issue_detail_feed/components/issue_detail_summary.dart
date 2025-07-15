import 'dart:developer';

import 'package:could_be/core/components/buttons/back_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/layouts/nested_page_view.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../../core/components/bias/bias_bar.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import 'header.dart';

class IssueDetailSummary extends StatefulWidget {
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
  State<IssueDetailSummary> createState() => _IssueDetailSummaryState();
}

class _IssueDetailSummaryState extends State<IssueDetailSummary> {
  final ScrollController scrollController = ScrollController();
  bool _atBottom = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        log('Reached the end of the summary');
        // widget.moveToNextPage();
        if(_atBottom){
          widget.moveToNextPage();
        }else{
          _atBottom = true;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: [
            widget.issue.imageUrl != null
                ? ImageContainer(
                  height: 200,
                  imageUrl: widget.issue.imageUrl,
                  borderRadius: BorderRadius.zero,
                )
                : SizedBox(height: MyPaddings.small),
            SizedBox(height: MyPaddings.medium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IssueDetailHeader(issue: widget.issue),
                  SizedBox(height: MyPaddings.large),
                  CardBiasBar(
                    coverageSpectrum: widget.issue.coverageSpectrum,
                    isDailyIssue: true,
                  ),
                  SizedBox(height: MyPaddings.large),
                  TextCard(
                    color: AppColors.gray1,
                    child: parseAiText(widget.issue.summary, widget.fontSize),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
            //   child: MoveToNextButton(
            //     moveToNextPage: widget.moveToNextPage,
            //     buttonText: '성향별 보도 내용 보기',
            //   ),
            // ),
          ],
        ),
        Align(alignment: Alignment.topLeft, child: MyBackButton()),
      ],
    );
  }
}
