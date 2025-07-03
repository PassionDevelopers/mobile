import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/articles.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/presentation/issue_detail_feed/components/Issue_detail_bias_comparison.dart';
import 'package:could_be/presentation/issue_detail_feed/components/custom_report_page.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_summary.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_tabs.dart';
import 'package:could_be/presentation/issue_detail_feed/components/source_list_page.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class IssueDetailFeedView extends StatefulWidget {
  const IssueDetailFeedView({
    super.key,
    required this.issue,
    required this.manageIssueSubscription,
  });

  final IssueDetail issue;
  final VoidCallback manageIssueSubscription;

  @override
  State<IssueDetailFeedView> createState() => _IssueDetailFeedViewState();
}

class _IssueDetailFeedViewState extends State<IssueDetailFeedView> {
  double currentPage = 0.0;
  int pageCount = 5;

  late final IssueDetail issue = widget.issue;
  late final PageController controller;

  late final mediaQuery = MediaQuery.of(context);

  late final safeAreaHeight = mediaQuery.size.height
      - mediaQuery.padding.top
      - mediaQuery.padding.bottom - kToolbarHeight - 8 * (pageCount -1) - 12 - 10;

  late final double indicatorHeight = safeAreaHeight / pageCount;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0.0;
      });
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [

                  IssueDetailSummary(issue: issue),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    child: IssueDetailTabs(issue: issue),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    child: IssueDetailBiasComparison(
                      onBiasSelected: (Bias bias){

                      },
                        biasComparison: issue.biasComparison),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    child: SourceListPage(articles: issue.articles.toGroupByBias()),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    child: CustomReportPage(),
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: controller, // PageController
              count: pageCount,
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
                dotWidth: indicatorHeight,
                dotHeight: 5,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: AppColors.primary,
                type: SlideType.slideUnder
              ),
            ),
          ],
        ),
      ],
    );
  }
}
