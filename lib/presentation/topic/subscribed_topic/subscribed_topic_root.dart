import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:flutter/material.dart';

class SubscribedTopicRoot extends StatelessWidget {
  const SubscribedTopicRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return IssueListRoot(
      isTopicView: true,
        issueType: IssueType.subscribedTopicIssuesWhole,
    );
  }
}
