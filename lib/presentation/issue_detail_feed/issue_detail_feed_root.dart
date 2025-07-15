import 'dart:developer';

import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/articles.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_common_summary.dart';
import 'package:could_be/presentation/issue_detail_feed/issue_detail_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../ui/color.dart';
import 'components/Issue_detail_bias_comparison.dart';
import 'components/issue_detail_summary.dart';
import 'components/issue_detail_tabs.dart';
import 'components/source_list_page.dart';
import 'issue_detail_view_model.dart';
import '../../core/responsive/responsive_utils.dart';

class IssueDetailFeedRoot extends StatefulWidget {
  final String issueId;

  const IssueDetailFeedRoot({super.key, required this.issueId});

  @override
  State<IssueDetailFeedRoot> createState() => _IssueDetailFeedRootState();
}

class _IssueDetailFeedRootState extends State<IssueDetailFeedRoot> {
  late final IssueDetailViewModel viewModel;

  late final ScrollController controller;
  double scrollProgress = 0.0;

  late final mediaQuery = MediaQuery.of(context);
  late final safeAreaHeight =
      mediaQuery.size.height -
      mediaQuery.padding.top -
      mediaQuery.padding.bottom;

  void _onScroll() {
    if (controller.hasClients) {
      final maxScroll = controller.position.maxScrollExtent;
      final currentScroll = controller.position.pixels;
      setState(() {
        scrollProgress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    viewModel = getIt<IssueDetailViewModel>(param1: widget.issueId);
    controller = ScrollController();
    controller.addListener(_onScroll);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: AppColors.primaryLight,
        child: Icon(size: 30, icon),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      backgroundColor: Colors.white,
      body: Ink(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width * scrollProgress,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

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
                                        moveToNextPage: () {
                                          moveToNextPage(1);
                                        },
                                      ),

                                      if (issue.commonSummary != null)
                                        IssueDetailCommonSummary(
                                          commonSummary: issue.commonSummary!,
                                          fontSize: state.fontSize,
                                          moveToNextPage: () {
                                            moveToNextPage(2);
                                          },
                                        ),

                                      IssueDetailTabs(
                                        fontSize: state.fontSize,
                                        issue: issue,
                                        moveToNextPage: () {
                                          moveToNextPage(
                                            issue.commonSummary != null ? 3 : 2,
                                          );
                                        },
                                      ),

                                      if (issue.biasComparison != null)
                                        ListenableBuilder(
                                          listenable: ValueNotifier(
                                            state.isEvaluating,
                                          ),
                                          builder: (context, listenable) {
                                            return IssueDetailBiasComparison(
                                              fontSize: state.fontSize,
                                              moveToNextPage: () {
                                                moveToNextPage(
                                                  issue.commonSummary != null
                                                      ? 4
                                                      : 3,
                                                );
                                              },
                                              existCenter:
                                                  issue.centerSummary != null,
                                              existLeft:
                                                  issue.leftSummary != null,
                                              existRight:
                                                  issue.rightSummary != null,
                                              isEvaluating: state.isEvaluating,
                                              onBiasSelected:
                                                  viewModel.manageIssueEvaluation,
                                              leftLikeCount: issue.leftLikeCount,
                                              centerLikeCount:
                                                  issue.centerLikeCount,
                                              rightLikeCount:
                                                  issue.rightLikeCount,
                                              userEvaluation:
                                                  issue.userEvaluation,
                                              biasComparison:
                                                  issue.biasComparison!,
                                            );
                                          },
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                floatingButton(
                                  onPressed: () {
                                    viewModel.setFontSize();
                                  },
                                  icon:
                                      viewModel.state.fontSize == 16
                                          ? Icons.format_size_outlined
                                          : Icons.format_size,
                                ),
                                floatingButton(
                                  onPressed: viewModel.manageIssueSubscription,
                                  icon:
                                      viewModel.state.issueDetail!.isSubscribed
                                          ? Icons.bookmark
                                          : Icons.bookmark_add_outlined,
                                ),
                              ],
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

