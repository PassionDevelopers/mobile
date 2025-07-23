import 'dart:developer';

import 'package:could_be/core/components/buttons/back_button.dart';
import 'package:could_be/core/components/cards/issue_detail_title_card.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
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
  });

  final IssueDetail issue;
  final double fontSize;

  @override
  State<IssueDetailSummary> createState() => _IssueDetailSummaryState();
}

class _IssueDetailSummaryState extends State<IssueDetailSummary> {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: [
            widget.issue.imageUrl != null
                ? Stack(
                  children: [
                    SizedBox(
                      height: 260,
                      child: Stack(
                        children: [
                          ImageContainer(
                            height: 260,
                            imageUrl: widget.issue.imageUrl,
                            borderRadius: BorderRadius.zero,
                            imageSource: widget.issue.imageSource,
                          ),
                          Container(
                            height: 260,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                                stops: [0.5, 1.0],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(MyPaddings.large),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.issue.title,
                                    style: MyFontStyle.h0.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 3,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if(widget.issue.imageSource != null && widget.issue.imageSource!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: MyPaddings.small),
                                      child: Text(
                                        '이미지 출처 : ${widget.issue.imageSource}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                : Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.8),
                          AppColors.primary,
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(MyPaddings.large),
                        child: Text(
                          widget.issue.title,
                          style: MyFontStyle.h0.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
            // SizedBox(height: MyPaddings.small),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.issue.tags.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: MyPaddings.large, left: MyPaddings.small),
                    child: SizedBox(
                      height: 24,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.issue.tags.length,
                        itemBuilder: (_, index) {
                          return BlindChip(
                            topPadding: 0,
                            isFirst: index == 0,
                            tag: widget.issue.tags[index],
                          );
                        },
                      ),
                    ),
                  ),
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              Icons.article_outlined,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            SizedBox(width: MyPaddings.medium),
                            Text(
                              '이슈 개요',
                              style: MyFontStyle.h2.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Sonkeechung',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(MyPaddings.large),
                        child: parseAiText(
                          widget.issue.summary,
                          widget.fontSize,
                          AppColors.gray1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          left: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
