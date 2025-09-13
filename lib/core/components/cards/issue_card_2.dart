import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IssueCard2 extends StatelessWidget {
  final Issue issue;

  const IssueCard2({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Log issue tap event
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.issueTapItem,
          parameters: {
            AnalyticsParameterKeys.issueId: issue.id,
            AnalyticsParameterKeys.issueTitle: issue.title,
            AnalyticsParameterKeys.issueCategory: issue.category,
            AnalyticsParameterKeys.issueTags: issue.tags.join(','),
          },
        );
        context.push(
          '${RouteNames.issueDetailFeed}/${issue.id}',
        );
      },
      child: Ink(
        width: 170,
        height: 211,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageContainer(
                  height: 100,
                  imageUrl: issue.imageUrl,
                  borderRadius: BorderRadius.circular(6),
                ),
                if(issue.tags.isNotEmpty) Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: ShapeDecoration(
                      color: AppColors.black.withValues(alpha: 0.80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            topRight: Radius.circular(4)
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(int i = 0; i < issue.tags.length; i++)
                          Text(
                            '${i > 0? ' · ' : ''}${issue.tags[i].name}',
                            style: TextStyle(
                              color: issue.tags[i].color,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            MyText.reg(issue.title, fontWeight: FontWeight.w500, maxLines: 2),
            SizedBox(height: 10),
            CardBiasBar(
              isDailyIssue: false,
              coverageSpectrum: issue.coverageSpectrum,
            ),
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: IssueInfoTitle(
                  mediaTotal: issue.coverageSpectrum.total,
                  viewCount: issue.view,
                  time: issue.createdAt,
                  isRead:issue.isRead,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
