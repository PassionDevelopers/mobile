import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:could_be/presentation/issue_detail_feed/components/header.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HotIssuePageCard extends StatelessWidget {
  const HotIssuePageCard({super.key, required this.issue});

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MyPaddings.medium,
        bottom: MyPaddings.extraLarge,
      ),
      child: Ink(
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
            ImageContainer(
              height: 172,
              imageUrl: issue.imageUrl,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              imageSource: issue.imageSource,
            ),
            Container(
              padding: EdgeInsets.all(MyPaddings.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.h2(issue.title, maxLines: 2),

                  if (issue.imageSource != null &&
                      issue.imageSource!.trim().isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: MyPaddings.small),
                      child: Text(
                        '이미지 출처 : ${issue.imageSource}',
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: MyPaddings.large,
                      left: MyPaddings.large,
                      top: MyPaddings.small,
                    ),
                    child: IssueDetailHeader(
                      title: issue.title,
                      coverageSpectrum: issue.coverageSpectrum,
                      tags: issue.tags,
                      mediaTotal: issue.coverageSpectrum.total,
                      viewCount: issue.view,
                      time: issue.createdAt,
                    ),
                  ),
                  SizedBox(height: MyPaddings.small),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MyPaddings.large,
                      left: MyPaddings.large,
                    ),
                    child: CardBiasBar(
                      coverageSpectrum: issue.coverageSpectrum,
                      isDailyIssue: true,
                    ),
                  ),
                  SizedBox(height: MyPaddings.small),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MyPaddings.large,
                        ),
                        child: parseAiText(
                          issue.summary,
                          15,
                          AppColors.gray700,
                          Colors.amberAccent,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    onTap: () {
                      context.push('${RouteNames.issueDetailFeed}/${issue.id}');
                    },
                    child: Ink(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                        color: AppColors.black
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText.reg(
                            '자세히 보기',
                            color: AppColors.white,
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.white,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
