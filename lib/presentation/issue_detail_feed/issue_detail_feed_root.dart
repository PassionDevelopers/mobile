import 'dart:developer';

import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/articles.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_common_summary.dart';
import 'package:could_be/presentation/issue_detail_feed/components/scroll_gage.dart';
import 'package:could_be/presentation/issue_detail_feed/issue_detail_loading_view.dart';
import 'package:flutter/material.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../core/responsive/responsive_utils.dart';
import '../../ui/color.dart';
import 'components/Issue_detail_bias_comparison.dart';
import 'components/issue_detail_summary.dart';
import 'components/issue_detail_tabs.dart';
import 'components/source_list_page.dart';
import 'issue_detail_view_model.dart';

class IssueDetailFeedRoot extends StatefulWidget {
  final String issueId;

  const IssueDetailFeedRoot({super.key, required this.issueId});

  @override
  State<IssueDetailFeedRoot> createState() => _IssueDetailFeedRootState();
}

class _IssueDetailFeedRootState extends State<IssueDetailFeedRoot> {
  late final IssueDetailViewModel viewModel;

  late final ScrollController controller;
  late final ValueNotifier<double> scrollProgressNotifier;

  late final mediaQuery = MediaQuery.of(context);
  late final safeAreaHeight =
      mediaQuery.size.height -
      mediaQuery.padding.top -
      mediaQuery.padding.bottom;

  void _onScroll() {
    if (controller.hasClients) {
      final maxScroll = controller.position.maxScrollExtent;
      final currentScroll = controller.position.pixels;
      scrollProgressNotifier.value = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
    }
  }

  @override
  void initState() {
    super.initState();
    log('IssueDetailFeedRoot initState called with issueId: ${widget.issueId}');
    viewModel = getIt<IssueDetailViewModel>(param1: widget.issueId);
    controller = ScrollController();
    controller.addListener(_onScroll);
    scrollProgressNotifier = ValueNotifier<double>(0.0);
  }

  Widget floatingButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        ResponsiveUtils.isMobile(context)
            ? MyPaddings.large.toDouble()
            : MyPaddings.extraLarge.toDouble(),
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white.withAlpha(1000),
        child: Icon(
          icon,
          size: 28,
          color: viewModel.state.issueDetail!.isSubscribed
              ? AppColors.primary
              : AppColors.gray2,
        ),
      ),
    );
  }

  void moveToNextPage(int page) {
    // controller.animateToPage(
    //   page,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    scrollProgressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: true,
      backgroundColor: AppColors.background,
      body: Ink(
        color: AppColors.background,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: scrollProgressNotifier,
              builder: (context, scrollProgress, _) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: scrollProgress > 0 ? 3 : 0,
                  child: ScrollGage(
                    scrollProgress: scrollProgress,
                  ),
                );
            }),
            Expanded(
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  final state = viewModel.state;
                  if (state.isLoading) {
                    return IssueDetailLoadingView();
                  } else {
                    if (state.issueDetail == null) {
                      return Center(child: Text('발견된 이슈가 없습니다.'));
                    } else {
                      final issue = state.issueDetail!;
                      return Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  controller: controller,
                                  child: Column(
                                    children: [
                                      IssueDetailSummary(
                                        issue: issue,
                                        fontSize: state.fontSize,
                                        isSubscribed: state.issueDetail!.isSubscribed,
                                        onSubscribe: viewModel.manageIssueSubscription,

                                      ),
                                      if (issue.commonSummary != null) SizedBox(height: MyPaddings.large),

                                      if (issue.commonSummary != null)
                                        IssueDetailCommonSummary(
                                          commonSummary: issue.commonSummary!,
                                          fontSize: state.fontSize,
                                          isSpread: state.isCommonSummarySpread,
                                          spreadCallback: viewModel.spreadCommonSummary
                                        ),
                                      if (issue.leftComparison != null ||
                                          issue.centerComparison != null ||
                                          issue.rightComparison != null)
                                        SizedBox(height: MyPaddings.large),

                                      if (issue.leftComparison != null ||
                                          issue.centerComparison != null ||
                                          issue.rightComparison != null)
                                        ListenableBuilder(
                                          listenable: ValueNotifier(
                                            state.isEvaluating,
                                          ),
                                          builder: (context, listenable) {
                                            return Column(
                                              children: [
                                                IssueDetailBiasComparison(
                                                  fontSize: state.fontSize,
                                                  moveToNextPage: () {
                                                    moveToNextPage(
                                                      issue.commonSummary != null
                                                          ? 4
                                                          : 3,
                                                    );
                                                  },
                                                  existCenter: issue.centerComparison != null,
                                                  existLeft: issue.leftComparison != null,
                                                  existRight: issue.rightComparison != null,
                                                  isEvaluating: state.isEvaluating,
                                                  onBiasSelected:
                                                  viewModel
                                                      .manageIssueEvaluation,
                                                  leftLikeCount:
                                                  issue.leftLikeCount,
                                                  centerLikeCount:
                                                  issue.centerLikeCount,
                                                  rightLikeCount:
                                                  issue.rightLikeCount,
                                                  userEvaluation:
                                                  issue.userEvaluation,
                                                  leftComparison: issue.leftComparison,
                                                  centerComparison:
                                                  issue.centerComparison,
                                                  rightComparison:
                                                  issue.rightComparison,
                                                ),

                                                SizedBox(height: MyPaddings.large),

                                                BiasCheckButton(
                                                  existCenter: issue.centerComparison != null,
                                                  existLeft: issue.leftComparison != null,
                                                  existRight: issue.rightComparison != null,
                                                  isEvaluating: state.isEvaluating,
                                                  onBiasSelected: (Bias bias){

                                                    viewModel.manageIssueEvaluation(bias);

                                                  },
                                                  leftLikeCount:
                                                  issue.leftLikeCount,
                                                  centerLikeCount:
                                                  issue.centerLikeCount,
                                                  rightLikeCount:
                                                  issue.rightLikeCount,
                                                  userEvaluation:
                                                  issue.userEvaluation,
                                                ),
                                              ],
                                            );
                                          },
                                        ),

                                      SizedBox(height: MyPaddings.large),
                                      IssueDetailTabs(
                                        fontSize: state.fontSize,
                                        issue: issue,
                                        moveToNextPage: () {
                                          moveToNextPage(
                                            issue.commonSummary != null ? 3 : 2,
                                          );
                                        },
                                        postDasiScore: viewModel.postDasiScore,
                                      ),

                                      SizedBox(height: MyPaddings.large),

                                      SourceListPage(
                                        articlesGBBAS:
                                            issue.articles
                                                .toGroupByBiasAndSource(),
                                        hasNextIssue:
                                            issue.nextIssueIds.isNotEmpty,
                                        toNextIssue: () {
                                          viewModel.fetchIssueDetailById(
                                            issue.nextIssueIds.first,
                                          );
                                        },
                                      ),
                                      SizedBox(height: MyPaddings.large),
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                                      //   child: CustomReportPage(),
                                      // ),
                                      BottomSafePadding()
                                    ],
                                  ),
                                ),
                              ),
                              // if (!ResponsiveUtils.isDesktop(context))
                              //   SmoothPageIndicator(
                              //     controller: controller,
                              //     count: state.pageCount,
                              //     axisDirection: Axis.vertical,
                              //     onDotClicked: (index) {
                              //       controller.animateToPage(
                              //         index,
                              //         duration: const Duration(milliseconds: 300),
                              //         curve: Curves.easeInOut,
                              //       );
                              //     },
                              //     effect: SlideEffect(
                              //       spacing: 0,
                              //       radius: 0,
                              //       dotWidth: safeAreaHeight / state.pageCount,
                              //       dotHeight: 5,
                              //       paintStyle: PaintingStyle.stroke,
                              //       strokeWidth: 1.5,
                              //       dotColor: Colors.grey,
                              //       activeDotColor: AppColors.primary,
                              //       type: SlideType.slideUnder,
                              //     ),
                              //   ),
                            ],
                          ),
                          Positioned(
                            bottom: 40,
                            right: 0,
                            child: AnimatedScale(
                              duration: Duration(milliseconds: 200),
                              scale: 1.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // floatingButton(
                                  //   onPressed: () {
                                  //     viewModel.setFontSize();
                                  //   },
                                  //   icon:
                                  //       viewModel.state.fontSize == 18
                                  //           ? Icons.format_size_outlined
                                  //           : Icons.format_size,
                                  // ),
                                  floatingButton(
                                    onPressed: viewModel.share,
                                    icon: Icons.share
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
