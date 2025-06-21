import 'package:could_be/presentation/issue_list/issue_list_loading_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../core/di/use_case/use_case.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_view.dart';
import '../issue_list/main/issue_list_view_model.dart';

class BlindSpotRoot extends StatelessWidget {
  const BlindSpotRoot({super.key, required this.onIssueSelected});
  final void Function(String issueId) onIssueSelected;
  @override
  Widget build(BuildContext context) {
    final viewModel = IssueListViewModel(
      fetchIssuesUseCase: fetchIssuesUseCase,
      issueType: IssueType.blindSpot,
    );
    return DefaultTabController(length: 2, child: Column(
      children: [
        Material(
          color: AppColors.background,
          child: TabBar(
            tabs: [
              Tab(text: '보수 사각지대'),
              Tab(text: '진보 사각지대'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Expanded(child: TabBarView(children: [
          ListenableBuilder(listenable: viewModel, builder: (context, _){
            final state = viewModel.state;
            if(state.isLoading){
              return IssueListLoadingView();
            }
            return SingleChildScrollView(child: IssueListView(
                issueList: state.issueList));
          }),
          ListenableBuilder(listenable: viewModel, builder: (context, _){
            final state = viewModel.state;
            if(state.isLoading){
              return IssueListLoadingView();
            }
            return SingleChildScrollView(child: IssueListView(
                issueList: state.issueList));
          }),
        ]))
      ],
    ));
  }
}
