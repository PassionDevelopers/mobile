import 'package:flutter/material.dart';
import '../../../core/di/use_case/use_case.dart';
import '../issue_list_loading_view.dart';
import '../issue_type.dart';
import 'issue_list_view.dart';
import 'issue_list_view_model.dart';

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
        final state = viewModel.state;
        if (state.isLoading) {
          return IssueListLoadingView();
        }else{
          if (state.issueList.isEmpty) {
            if(issueType == IssueType.watchHistroy){
              return Center(child: Text('아직 본 이슈가 없습니다'));
            }else if(issueType == IssueType.subscribed){
              return Center(child: Text('아직 관심 이슈가 없습니다'));
            }
            return Center(child: Text('아직 이슈가 없습니다'));
          }else{
            return IssueListView(issueList: state.issueList);
          }
        }
      },
    );
  }
} 