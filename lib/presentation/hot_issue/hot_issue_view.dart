import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/presentation/issue_detail_feed/components/header.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_summary.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class HotIssueView extends StatefulWidget {
  const HotIssueView({super.key, required this.hotIssues});
  final HotIssues hotIssues;
  @override
  State<HotIssueView> createState() => _HotIssueViewState();
}

class _HotIssueViewState extends State<HotIssueView> {
  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      backgroundColor: AppColors.background,
      body: Ink(
        color: AppColors.background,
        child: Column(
          children: [
            // IssueDetailSummary(
            //   issue: issue,
            //   fontSize: state.fontSize,
            // ),
            // if (issue.commonSummary != null) SizedBox(height: MyPaddings.extraLarge),
            //
            // if (issue.commonSummary != null)
            //   IssueDetailCommonSummary(
            //     commonSummary: issue.commonSummary!,
            //     fontSize: state.fontSize,
            //   ),
            // if (issue.leftComparison != null ||
            //     issue.centerComparison != null ||
            //     issue.rightComparison != null)
            //   SizedBox(height: MyPaddings.large),
            //
            // if (issue.leftComparison != null ||
            //     issue.centerComparison != null ||
            //     issue.rightComparison != null)
            //   ListenableBuilder(
            //     listenable: ValueNotifier(
            //       state.isEvaluating,
            //     ),
            //     builder: (context, listenable) {
            //       return IssueDetailBiasComparison(
            //         fontSize: state.fontSize,
            //         moveToNextPage: () {
            //           moveToNextPage(
            //             issue.commonSummary != null
            //                 ? 4
            //                 : 3,
            //           );
            //         },
            //         existCenter: issue.centerComparison != null,
            //         existLeft: issue.leftComparison != null,
            //         existRight: issue.rightComparison != null,
            //         isEvaluating: state.isEvaluating,
            //         onBiasSelected:
            //         viewModel
            //             .manageIssueEvaluation,
            //         leftLikeCount:
            //         issue.leftLikeCount,
            //         centerLikeCount:
            //         issue.centerLikeCount,
            //         rightLikeCount:
            //         issue.rightLikeCount,
            //         userEvaluation:
            //         issue.userEvaluation,
            //         leftComparison: issue.leftComparison,
            //         centerComparison:
            //         issue.centerComparison,
            //         rightComparison:
            //         issue.rightComparison,
            //       );
            //     },
            //   ),
            //
            // SizedBox(height: MyPaddings.extraLarge),
            // IssueDetailTabs(
            //   fontSize: state.fontSize,
            //   issue: issue,
            //   moveToNextPage: () {
            //     moveToNextPage(
            //       issue.commonSummary != null ? 3 : 2,
            //     );
            //   },
            //   postDasiScore: viewModel.postDasiScore,
            // ),
            //
            // SizedBox(height: MyPaddings.extraLarge),
            //
            // SourceListPage(
            //   articlesGBBAS:
            //   issue.articles
            //       .toGroupByBiasAndSource(),
            //   hasNextIssue:
            //   issue.nextIssueIds.isNotEmpty,
            //   toNextIssue: () {
            //     viewModel.fetchIssueDetailById(
            //       issue.nextIssueIds.first,
            //     );
            //   },
            // ),
            // SizedBox(height: MyPaddings.extraLarge),
          ],
        )
      ),
    );
  }
}
