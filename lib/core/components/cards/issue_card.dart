import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/issue/issue.dart';
import '../../themes/color.dart';
import '../../analytics/analytics_event_names.dart';
import '../../analytics/analytics_parameter_keys.dart';
import '../../analytics/analytics_screen_names.dart';
import '../../analytics/unified_analytics_helper.dart';
import '../../responsive/responsive_utils.dart';
import '../../themes/margins_paddings.dart';
import '../bias/bias_bar.dart';
import '../chips/blind_chip.dart';

class IssueCard extends StatefulWidget {
  final Issue issue;
  final bool isDailyIssue;
  final bool? isEvaluating;
  final bool isEvaluatedView;
  final void Function(Bias bias)? onBiasSelected;

  const IssueCard({
    super.key,
    required this.issue,
    required this.isDailyIssue,
    this.isEvaluating,
    this.isEvaluatedView = false,
    this.onBiasSelected,
  });

  @override
  State<IssueCard> createState() => _IssueCardState();
}

class _IssueCardState extends State<IssueCard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 1.05,
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = 160;
    final responsivePadding = ResponsiveUtils.getResponsivePadding(
      context,
      mobile: MyPaddings.largeMedium.toDouble(),
      tablet: MyPaddings.large.toDouble(),
      desktop: MyPaddings.medium.toDouble(),
    );

    return Column(
      children: [
        InkWell(
          onTap: () {
            // Log issue tap event
            UnifiedAnalyticsHelper.logEvent(
              name: AnalyticsEventNames.issueTapItem,
              parameters: {
                AnalyticsParameterKeys.issueId: widget.issue.id,
                AnalyticsParameterKeys.issueTitle: widget.issue.title,
                AnalyticsParameterKeys.issueCategory: widget.issue.category,
                AnalyticsParameterKeys.issueTags: widget.issue.tags.join(','),
                AnalyticsParameterKeys.fromScreen: widget.isEvaluatedView ? AnalyticsScreenNames.manageIssueEvaluationScreen : AnalyticsScreenNames.homeScreen,
              },
            );
            context.push(
              '${RouteNames.issueDetailFeed}/${widget.issue.id}',
            );
          },
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.medium),
            decoration: BoxDecoration(
              color: AppColors.white,
              // border: Border.all(
              //   color: AppColors.gray4,
              //   width: 1.5,
              // ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageContainer(
                      height: 172,
                      imageUrl: widget.issue.imageUrl,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          height: 32,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: widget.issue.tags.length,
                                  itemBuilder: (_, index) {
                                    return BlindChip(
                                      tag: widget.issue.tags[index],
                                    );
                                  },
                                ),
                              ),
                              Expanded(child: Align(
                                alignment: Alignment.centerRight,
                                child: IssueInfoTitle(
                                  mediaTotal:
                                  widget.issue.coverageSpectrum.total,
                                  viewCount: widget.issue.view,
                                  time: widget.issue.createdAt,
                                  isRead: widget.issue.isRead,
                                ),
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MyText.h2(
                      widget.issue.title,
                      maxLines: 2,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 10),
                    CardBiasBar(
                      isDailyIssue: false,
                      coverageSpectrum:
                      widget.issue.coverageSpectrum,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (widget.onBiasSelected != null && widget.isEvaluatedView)
          Padding(
            padding: const EdgeInsets.only(top: MyPaddings.medium),
            child: BiasCheckButton(
              userEvaluation: widget.issue.userEvaluatedPerspective,
              onBiasSelected: widget.onBiasSelected!,
              leftLikeCount: widget.issue.leftLikeCount,
              centerLikeCount: widget.issue.centerLikeCount,
              rightLikeCount: widget.issue.rightLikeCount,
              isEvaluating: widget.isEvaluating ?? false,
              existLeft:
                  widget.issue.coverageSpectrum.left > 0 ||
                  widget.issue.coverageSpectrum.centerLeft > 0,
              existCenter: widget.issue.coverageSpectrum.center > 0,
              existRight:
                  widget.issue.coverageSpectrum.right > 0 ||
                  widget.issue.coverageSpectrum.centerRight > 0,
            ),
          ),
      ],
    );
  }
}
