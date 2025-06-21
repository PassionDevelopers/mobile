import 'package:could_be/core/components/cards/news_card.dart';
import 'package:flutter/material.dart';
import '../../core/themes/margins_paddings.dart';
import '../../domain/entities/issue.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';

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
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MyPaddings.medium,
              vertical: MyPaddings.small,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${DateTime.now().month}월 ${DateTime.now().day}일 이슈 Top5',
                style: MyFontStyle.h1,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                for (int i = 0; i < issueList.length; i++) NewsCard(issue: issueList[i], isDailyIssue: true),
              ],
            ),
          ),
          TabPageSelector(
            controller: tabController,
            selectedColor: AppColors.primary,
            borderStyle: BorderStyle.none,
          ),
        ],
      ),
    );
  }
}
