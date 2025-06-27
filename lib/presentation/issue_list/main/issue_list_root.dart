import 'package:flutter/material.dart';
import '../../../core/di/di_setup.dart';
import '../issue_list_loading_view.dart';
import '../issue_type.dart';
import 'issue_list_view.dart';
import 'issue_list_view_model.dart';

class IssueListRoot extends StatelessWidget {
  final IssueType issueType;
  final String? topicId;

  const IssueListRoot({super.key, required this.issueType, this.topicId});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<IssueListViewModel>(param1: issueType, param2: topicId);
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