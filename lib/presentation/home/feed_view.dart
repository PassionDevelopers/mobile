import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';

import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_root.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return IssueListRoot(
      issueType: IssueType.daily,
      isFeedView: true,
      isTopicView: false,
      upperWidget: SizedBox(height: MyPaddings.medium),
    );
  }
}
