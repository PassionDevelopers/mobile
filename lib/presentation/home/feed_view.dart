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
      // upperWidget: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium,
      //   vertical: MyPaddings.mediumLarge),
      //   child: InkWell(
      //     onTap: () {
      //
      //     },
      //     child: Ink(
      //       height: 100,
      //       width: double.infinity,
      //       padding: EdgeInsets.symmetric(
      //         vertical: MyPaddings.mediumLarge,
      //       ),
      //       decoration: BoxDecoration(
      //         color: AppColors.primaryLight,
      //         borderRadius: BorderRadius.circular(16.0),
      //         boxShadow: myShadow
      //       ),
      //       child: MyText.h3('오늘의 이슈'),
      //     )
      //   )
      // )
    );
  }
}
