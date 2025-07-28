import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/issue.dart';
import 'package:could_be/presentation/issue_detail_feed/components/header.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HotIssuePageCard extends StatelessWidget {
  const HotIssuePageCard({super.key, required this.issue});
  final Issue issue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MyPaddings.medium, bottom: MyPaddings.extraLarge),
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
          Stack(
            children: [
              ImageContainer(
                height: 145,
                imageUrl: issue.imageUrl,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                imageSource: issue.imageSource,
              ),
              Container(
                height: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(MyPaddings.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.h2(
                        issue.title,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                        maxLines: 2,
                      ),

                      if(issue.imageSource != null && issue.imageSource!.trim().isNotEmpty)
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
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: MyPaddings.large, left: MyPaddings.large, top: MyPaddings.small),
                  child: IssueDetailHeader(
                    mediaTotal: issue.coverageSpectrum.total,
                    viewCount: issue.view,
                    time: issue.createdAt,
                  ),
                ),
                SizedBox(height: MyPaddings.small),
                Padding(
                  padding: EdgeInsets.only(right: MyPaddings.large, left: MyPaddings.large),
                  child: CardBiasBar(
                    coverageSpectrum: issue.coverageSpectrum,
                    isDailyIssue: true,
                  ),
                ),
                SizedBox(height: MyPaddings.small),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                      child: parseAiText(
                        issue.summary,
                        15,
                        AppColors.gray1,
                        Colors.amberAccent
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(RouteNames.issueDetailFeed, extra: issue.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: MyPaddings.medium, top: MyPaddings.extraSmall),
                    child: Center(child: MyText.reg('자세히 보기', color: AppColors.gray2, decoration: TextDecoration.underline, decorationColor: AppColors.gray2, )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
