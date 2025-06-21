import 'package:flutter/material.dart';

import '../../../core/components/cards/news_card.dart';
import '../../../domain/entities/issue.dart';


class IssueListView extends StatelessWidget {
  const IssueListView({super.key, required this.issueList});
  final List<Issue> issueList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < issueList.length; i++)
          NewsCard(issue: issueList[i], isDailyIssue: false),
      ],
    );
  }
}
