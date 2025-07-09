import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
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
              log(widget.issue.tags.toString());
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
                              if (widget.issue.imageUrl != null)
                                SizedBox(
                                  height: ResponsiveUtils.isMobile(context) ? 220 : 250,
                                  child: Stack(
                                    children: [
                                      ImageContainer(
                                        height: ResponsiveUtils.isMobile(context) ? 220 : 250,
                                        imageUrl: widget.issue.imageUrl!,
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
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(16),
                                            color: Colors.white.withOpacity(
                                              0.60,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText.h2(
                                                widget.issue.title,
                                                maxLines: 2,
                                              ),
                                              SizedBox(
                                                height: MyPaddings.small,
                                              ),
                                              MyText.regSummary(
                                                widget.issue.summary,
                                                // color: AppColors.gray2,
                                                maxLines: 2,
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
                                      mediaTotal: widget.issue.coverageSpectrum.total,
                                      viewCount: widget.issue.view,
                                      time: widget.issue.updatedAt ?? widget.issue.createdAt,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          if (widget.issue.tags.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.all(MyPaddings.medium),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    height: 25,
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
            BiasCheckButton(
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
        ],
      ),
    );
  }
}
