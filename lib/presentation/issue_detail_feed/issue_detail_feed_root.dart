import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/shorts/shorts_loading_view.dart';
import 'package:could_be/presentation/shorts/shorts_view_model.dart';
import 'package:flutter/material.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import 'issue_detail_feed_view.dart';

class IssueDetailFeedRoot extends StatelessWidget {
  final String issueId;

  const IssueDetailFeedRoot({super.key, required this.issueId});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<IssueDetailViewModel>(param1: issueId);
    return MyScaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          if (state.isLoading) {
            return ShortsLoadingView();
          } else {
            if (state.issueDetail == null) {
              return Center(child: Text('발견된 이슈가 없습니다.'));
            }
            return IssueDetailFeedView(issue: state.issueDetail!,
                manageIssueSubscription: viewModel.manageIssueSubscription);
          }
        },
      ),
    );
  }
}
