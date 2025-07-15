import 'dart:developer';

import 'package:could_be/core/components/buttons/back_button.dart';
import 'package:could_be/core/components/cards/issue_detail_title_card.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/layouts/nested_page_view.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
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
                ? Stack(
                  children: [
                    ImageContainer(
                      height: 200,
                      imageUrl: widget.issue.imageUrl,
                      borderRadius: BorderRadius.zero,
                      imageSource:  widget.issue.imageSource,
                    ),
                  ],
                )
                : SizedBox(height: MyPaddings.small),
            if(widget.issue.imageSource != null) Container(
              padding: EdgeInsets.only(bottom: 5, right: 5),
              child: Align(alignment: Alignment.bottomRight,
                  child: Text('이미지 출처 : ${widget.issue.imageSource}',
                      style: TextStyle(color: AppColors.gray3, fontSize: 9))),
            ),
            // SizedBox(height: MyPaddings.small),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: IssueDetailHeader(issue: widget.issue),
                ),
                SizedBox(height: MyPaddings.large),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: CardBiasBar(
                    coverageSpectrum: widget.issue.coverageSpectrum,
                    isDailyIssue: true,
                  ),
                ),
                SizedBox(height: MyPaddings.large),
                IssueDetailTitleCard(
                  icon: Icon(Icons.article_outlined),
                  title: BigTitle(title: '이슈 개요'),
                ),
                SizedBox(height: MyPaddings.medium),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: TextCard(
                    color: AppColors.gray1,
                    child: parseAiText(widget.issue.summary, widget.fontSize, AppColors.gray1),
                  ),
                ),
              ],
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
