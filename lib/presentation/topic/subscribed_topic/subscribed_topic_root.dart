import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:flutter/material.dart';
import '../../../core/components/app_bar/app_bar.dart';

class SubscribedTopicRoot extends StatelessWidget {
  const SubscribedTopicRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return IssueListRoot(
      appBar: RegAppBar(
        title: '관심 토픽의 이슈 보기',
        iconData: Icons.explore_rounded,
      ),
      isTopicView: true,
      issueType: IssueType.subscribedTopicIssuesWhole
    );
  }
}

