import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/shorts/shorts_component.dart';
import 'package:could_be/presentation/shorts/shorts_loading_view.dart';
import 'package:could_be/presentation/shorts/shorts_view_model.dart';
import 'package:flutter/material.dart';
import '../../core/components/buttons/label_icon_button.dart';
import '../../core/components/layouts/scaffold_layout.dart';

class ShortsRoot extends StatelessWidget {
  final String issueId;

  const ShortsRoot({super.key, required this.issueId});

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
            return PageView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ShortsComponent(issue: state.issueDetail!, manageIssueSubscription: viewModel.manageIssueSubscription,),
                    ShortsComponent(issue: state.issueDetail!, manageIssueSubscription: viewModel.manageIssueSubscription,),
                  ]
              );
          }
        },
      ),
    );
  }
}
