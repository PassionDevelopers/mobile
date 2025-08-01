import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../bias/bias_bar.dart';
import '../chips/blind_chip.dart';
import '../chips/key_word_chip_component.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_layout.dart';
import '../../analytics/analytics_manager.dart';
import '../../analytics/analytics_event_types.dart';

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
                      AnalyticsManager.logIssueEvent(
                        IssueEvent.tapIssueCard,
                        issueId: widget.issue.id,
                        issueTitle: widget.issue.title,
                        issueCategory: widget.issue.category,
                        issueTags: widget.issue.tags,
                        additionalParams: {
                          'from_screen': widget.isEvaluatedView ? 'evaluated_issues' : 'issue_list',
                        },
                      );
                      
                      context.push(
                        RouteNames.issueDetailFeed,
                        extra: widget.issue.id,
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primaryLight,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray4,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height:
                                    ResponsiveUtils.isMobile(context)
                                        ? 220
                                        : 250,
                                child: Stack(
                                  children: [
                                    widget.issue.imageUrl != null
                                        ? ImageContainer(
                                          height: 220,
                                          imageUrl: widget.issue.imageUrl!,
                                        )
                                        : Ink(
                                          height: 220,
                                          decoration: BoxDecoration(
                                            color: AppColors.gray4,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: AppColors.gray2,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                    Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            AppColors.black.withOpacity(0.3),
                                            AppColors.black.withOpacity(0.8),
                                          ],
                                          stops: [0, 0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.fromLTRB(
                                          MyPaddings.large,
                                          MyPaddings.small,
                                          MyPaddings.large,
                                          MyPaddings.small,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.h2(
                                              widget.issue.title,
                                              maxLines: 2,
                                              color: AppColors.white,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0, 1),
                                                  blurRadius: 3,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: MyPaddings.small),
                                            parseAiTextSummary(
                                              widget.issue.summary,
                                              12,
                                              AppColors.gray5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  MyPaddings.large,
                                  MyPaddings.small,
                                  MyPaddings.large,
                                  MyPaddings.large,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Bias Bar
                                    SizedBox(
                                      height: 26,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, index) {
                                          return KeyWordChip(
                                            title: widget.issue.keywords[index],
                                          );
                                        },
                                        itemCount: widget.issue.keywords.length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                    SizedBox(height: MyPaddings.medium),
                                    CardBiasBar(
                                      isDailyIssue: true,
                                      coverageSpectrum:
                                          widget.issue.coverageSpectrum,
                                    ),
                                    SizedBox(height: MyPaddings.medium),
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

                          if (widget.issue.tags.isNotEmpty)
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                height: 32,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal : MyPaddings.small
                                  ),
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
                            ),
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
