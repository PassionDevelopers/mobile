import 'package:could_be/presentation/issue_list_view/issue_list_view.dart';
import 'package:could_be/presentation/views/loading_view.dart';
import 'package:flutter/material.dart';
import '../../../core/di/use_case/issue_use_case.dart';
import '../view_models/issue_list_view_model.dart';
import '../issue_type.dart';

class IssueListRoot extends StatelessWidget {
  final IssueType issueType;

  const IssueListRoot({super.key, required this.issueType});

  @override
  Widget build(BuildContext context) {
    final viewModel = IssueListViewModel(
      fetchIssuesUseCase: fetchIssuesUseCase,
      issueType: issueType,
    );
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.isLoading) {
          return SliverToBoxAdapter(child: LoadingView());
        }
        return IssueListView(issueList: viewModel.issues);
      },
    );
  }
} 