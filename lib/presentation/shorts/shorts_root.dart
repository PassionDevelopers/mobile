import 'package:could_be/presentation/shorts/shorts_loading_view.dart';
import 'package:could_be/presentation/shorts/shorts_view.dart';
import 'package:could_be/presentation/shorts/shorts_view_model.dart';
import 'package:flutter/material.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../core/di/use_case/use_case.dart';

class ShortsRoot extends StatelessWidget {
  final String issueId;

  const ShortsRoot({super.key, required this.issueId});

  @override
  Widget build(BuildContext context) {
    final viewModel = ShortsViewModel(
      fetchWholeIssueUseCase: fetchWholeIssueUseCase,
      issueId: issueId, // Assuming issueType has an issueId property
    );
    return MyScaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          if (state.isLoading) {
            return ShortsLoadingView();
          } else {
            if (state.wholeIssue == null) {
              return Center(child: Text('No issue found'));
            }
            return ShortsView(wholeIssue: state.wholeIssue!);
          }
        },
      ),
    );
  }
}
