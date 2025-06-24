import 'package:could_be/core/components/title/big_title.dart';
import 'package:flutter/material.dart';
import '../../../core/components/cards/issue_card.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';

class HotIssueListView extends StatefulWidget {
  const HotIssueListView({super.key, required this.issueList});
  final List<Issue> issueList;
  @override
  State<HotIssueListView> createState() => _HotIssueListViewState();
}

class _HotIssueListViewState extends State<HotIssueListView> with TickerProviderStateMixin {
  late final List<Issue> issueList = widget.issueList;
  late final TabController tabController = TabController(
    length: issueList.length,
    vsync: this,
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: MyPaddings.largeMedium,),
            child: BigTitle(title: '${DateTime.now().month}월 ${DateTime.now().day}일 주요 이슈'),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                for (int i = 0; i < issueList.length; i++) Center(child: IssueCard(issue: issueList[i], isDailyIssue: true)),
              ],
            ),
          ),
          TabPageSelector(
            controller: tabController,
            selectedColor: AppColors.gray2,
            color: AppColors.gray4,
            borderStyle: BorderStyle.none,
          ),
        ],
      ),
    );
  }
}
