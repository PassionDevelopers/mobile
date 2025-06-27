import 'package:flutter/material.dart';
import '../../../core/di/di_setup.dart';
import '../../issue_list/issue_list_loading_view.dart';
import '../../issue_list/issue_type.dart';
import '../../issue_list/main/issue_list_view_model.dart';
import 'hot_issue_list_view.dart';

class HotIssueRoot extends StatelessWidget {
  const HotIssueRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<IssueListViewModel>(
      param1: IssueType.hot
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
