

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:flutter/material.dart';

class WatchHistoryView extends StatelessWidget {
  const WatchHistoryView({super.key });

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      body: IssueListRoot(
        appBar: RegAppBar(title: '내가 본 이슈'),
        upperWidget: SizedBox(height: MyPaddings.large,),
        issueType: IssueType.watchHistroy,
      )
    );
  }
}
