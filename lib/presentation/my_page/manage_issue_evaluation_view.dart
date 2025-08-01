import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:flutter/material.dart';

class ManageIssueEvaluationView extends StatelessWidget {
  const ManageIssueEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: true,
      body: IssueListRoot(issueType: IssueType.evaluated,
      isEvaluatedView: true,
      appBar: RegAppBar(
        title: '내가 평가한 이슈',
      ),
      upperWidget: SizedBox(height: MyPaddings.large,),
    )
    );
  }
}
