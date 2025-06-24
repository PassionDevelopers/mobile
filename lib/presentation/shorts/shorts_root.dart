import 'package:could_be/presentation/shorts/shorts_component.dart';
import 'package:could_be/presentation/shorts/shorts_loading_view.dart';
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
      fetchIssueDetailUseCase: fetchIssueDetailUseCase,
      manageIssueSubscriptionUseCase: manageIssueSubscriptionUseCase,
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
            if (state.issueDetail == null) {
              return Center(child: Text('발견된 이슈가 없습니다.'));
            }
            print('state.issueDetail: ${state.issueDetail!.isSubscribed}');
            return ShortsComponent(issue: state.issueDetail!, manageIssueSubscripton: viewModel.manageIssueSubscription,);

          // return PageView(
            //     scrollDirection: Axis.vertical,
            //     children: [
            //       ShortsComponent(issue: state.issueDetail!, manageIssueSubscripton: viewModel.manageIssueSubscription,),
            //       ShortsComponent(issue: state.issueDetail!, manageIssueSubscripton: viewModel.manageIssueSubscription,),
            //     ]
            // );
          }
        },
      ),
    );
  }
}
