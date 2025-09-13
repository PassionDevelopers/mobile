import 'package:could_be/core/components/cards/hot_issue_card_2.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/main_feed/main_feed_view_model.dart';
import 'package:flutter/material.dart';

class HotIssueCardView extends StatelessWidget {
  const HotIssueCardView({super.key, required this.viewModel, required this.hotIssuesViewModel});

  final MainFeedViewModel viewModel;
  final HotIssuesViewModel hotIssuesViewModel;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: hotIssuesViewModel,
      builder: (context, _) {
        final state = viewModel.state;
        bool isDailyQueryParam =
            state.issueQueryParam != null &&
                state.issueQueryParam!.queryParam == IssueType.daily.name;

        bool isDailyIssueType = state.issueQueryParam == null;
        if ((isDailyQueryParam || isDailyIssueType) &&
            hotIssuesViewModel.state.hotIssues != null &&
            !hotIssuesViewModel.state.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HotIssueCard2(
              updateTime: hotIssuesViewModel.state.hotIssues!.hotTime,
              hotIssues: hotIssuesViewModel.state.hotIssues!,
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
