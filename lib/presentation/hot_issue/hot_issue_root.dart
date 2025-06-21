

import 'package:flutter/material.dart';

import '../../core/di/use_case/use_case.dart';
import '../issue_list/issue_list_loading_view.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_view_model.dart';
import 'hot_issue_list_view.dart';

class HotIssueRoot extends StatelessWidget {
  final IssueType issueType;
  const HotIssueRoot({super.key, required this.issueType});

  @override
  Widget build(BuildContext context) {
    final viewModel = IssueListViewModel(
      fetchIssuesUseCase: fetchIssuesUseCase,
      issueType: issueType,
    );
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        if (state.isLoading) {
          return IssueListLoadingView();
        }
        return HotIssueListView(issueList: state.issueList);
      },
    );
  }
}
