import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';
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

    return Padding(
      padding: EdgeInsets.fromLTRB(
        responsivePadding.left,
        0,
        responsivePadding.right,
        responsivePadding.bottom,
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: GestureDetector(
                  onTapDown: (_) => _animationController.forward(),
                  onTapUp: (_) {
                    _animationController.reverse();
                  },
                  onTapCancel: () => _animationController.reverse(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primaryLight,
                        // border: Border.all(
                        //   color: AppColors.gray4,
                        //   width: 1.5,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray4,
                            spreadRadius: 0.5,
                            blurRadius: 0.5,
                            offset: Offset(0, 0.5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ImageContainer(
                                    height: height,
                                    imageUrl: widget.issue.imageUrl,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  MyPaddings.large,
                                  0,
                                  MyPaddings.large,
                                  MyPaddings.medium,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Bias Bar
                                    // SizedBox(
                                    //   height: 26,
                                    //   child: ListView.builder(
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemBuilder: (_, index) {
                                    //       return KeyWordChip(
                                    //         title: widget.issue.keywords[index],
                                    //       );
                                    //     },
                                    //     itemCount: widget.issue.keywords.length,
                                    //     shrinkWrap: true,
                                    //   ),
                                    // ),
                                    if (widget.issue.tags.isNotEmpty)
                                      SizedBox(
                                        height: 32,
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
                                    SizedBox(height: MyPaddings.small),
                                    MyText.h2(
                                      widget.issue.title,
                                      maxLines: 2,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(height: MyPaddings.small),
                                    CardBiasBar(
                                      isDailyIssue: false,
                                      coverageSpectrum:
                                          widget.issue.coverageSpectrum,
                                    ),
                                    SizedBox(height: MyPaddings.small),
                                    IssueInfoTitle(
                                      mediaTotal:
                                          widget.issue.coverageSpectrum.total,
                                      viewCount: widget.issue.view,
                                      time: widget.issue.createdAt,
                                      isRead: widget.issue.isRead,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // if (widget.issue.tags.isNotEmpty)
                          //   Align(
                          //     alignment: Alignment.topLeft,
                          //     child: SizedBox(
                          //       height: 32,
                          //       child: ListView.builder(
                          //         padding: EdgeInsets.symmetric(
                          //           horizontal : MyPaddings.small
                          //         ),
                          //         scrollDirection: Axis.horizontal,
                          //         shrinkWrap: true,
                          //         itemCount: widget.issue.tags.length,
                          //         itemBuilder: (_, index) {
                          //           return BlindChip(
                          //             tag: widget.issue.tags[index],
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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
      ),
    );
  }
}
