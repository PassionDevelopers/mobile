import 'package:could_be/core/components/loading/issue_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/loading/skeleton.dart';

class IssueListLoadingView extends StatefulWidget {
  const IssueListLoadingView({super.key});

  @override
  State<IssueListLoadingView> createState() => _IssueListLoadingViewState();
}

class _IssueListLoadingViewState extends State<IssueListLoadingView> {
  String fetchedIssues = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        for(int i = 0; i < 10; i++)
          IssueCardSkeleton()
      ]
    );
  }
}
