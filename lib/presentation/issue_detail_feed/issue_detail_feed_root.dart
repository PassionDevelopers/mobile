import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/articles.dart';
import 'package:could_be/presentation/issue_detail_feed/issue_detail_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/components/layouts/scaffold_layout.dart';
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

  double currentPage = 0.0;

  late final PageController controller;

  late final mediaQuery = MediaQuery.of(context);

  late final safeAreaHeight =
      mediaQuery.size.height -
      mediaQuery.padding.top -
      mediaQuery.padding.bottom;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<IssueDetailViewModel>(param1: widget.issueId);
    controller = PageController(initialPage: 0, viewportFraction: 1.0);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0.0;
      });
    });
  }

  void moveToNextPage(int page) {
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListenableBuilder(
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
                        child: PageView(
                          scrollDirection: Axis.vertical,
                          controller: controller,
                          children: [
                            IssueDetailSummary(
                              issue: issue,
                              moveToNextPage: () {
                                moveToNextPage(1);
                              },
                            ),

                            IssueDetailTabs(
                              issue: issue,
                              moveToNextPage: () {
                                moveToNextPage(2);
                              },
                            ),

                            if (issue.biasComparison != null)
                              ListenableBuilder(
                                listenable: ValueNotifier(state.isEvaluating),
                                builder: (context, listenable) {
                                  return IssueDetailBiasComparison(
                                    moveToNextPage: () {
                                      moveToNextPage(3);
                                    },
                                    existCenter: issue.centerSummary != null,
                                    existLeft: issue.leftSummary != null,
                                    existRight: issue.rightSummary != null,
                                    isEvaluating: state.isEvaluating,
                                    onBiasSelected:
                                        viewModel.manageIssueEvaluation,
                                    leftLikeCount: issue.leftLikeCount,
                                    centerLikeCount: issue.centerLikeCount,
                                    rightLikeCount: issue.rightLikeCount,
                                    userEvaluation: issue.userEvaluation,
                                    biasComparison: issue.biasComparison!,
                                  );
                                },
                              ),

                            SourceListPage(
                              articles: issue.articles.toGroupByBias(),
                              hasNextIssue: issue.nextIssueIds.isNotEmpty,
                              toNextIssue: () {
                                viewModel.fetchIssueDetailById(
                                  issue.nextIssueIds.first,
                                );
                              },
                            ),

                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                            //   child: CustomReportPage(),
                            // ),
                          ],
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: state.pageCount,
                        axisDirection: Axis.vertical,
                        onDotClicked: (index) {
                          controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        effect: SlideEffect(
                          spacing: 0,
                          radius: 0,
                          dotWidth: safeAreaHeight / state.pageCount,
                          dotHeight: 5,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1.5,
                          dotColor: Colors.grey,
                          activeDotColor: AppColors.primary,
                          type: SlideType.slideUnder,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(MyPaddings.large),
                      child: FloatingActionButton(
                        onPressed: () {
                          viewModel.manageIssueSubscription();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(
                          size: 30,
                          viewModel.state.issueDetail!.isSubscribed
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
