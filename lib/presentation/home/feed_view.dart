import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/presentation/home/hot_issue/hot_issue_root.dart';
import 'package:flutter/material.dart';

import '../../../core/components/chips/issue_chip.dart';
import '../../../ui/color.dart';
import '../../core/themes/margins_paddings.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_root.dart';

class FeedView extends StatelessWidget {
  final void Function(String issueId) onIssueSelected;

  FeedView({super.key, required this.onIssueSelected});

  final List<String> issueCategories = [
    '데일리 이슈',
    '추천 이슈',
    '심한 대립'
  ];

  late List<bool> issueActive = List.generate(
    issueCategories.length,
    (index) => index == 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.background,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: MyPaddings.small, horizontal: MyPaddings.largeMedium),
            child: StatefulBuilder(
              builder: (context, setChipState) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: issueCategories.length,
                  itemBuilder: (context, index) {
                    return IssueChip(
                      title: issueCategories[index],
                      isActive: issueActive[index],
                      onTap: () {
                        setChipState(() {
                          for (int i = 0; i < issueActive.length; i++) {
                            issueActive[i] = i == index;
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HotIssueRoot(),
                Padding(
                  padding: EdgeInsets.only(left: MyPaddings.largeMedium, bottom: MyPaddings.small),
                  child: BigTitle(title: '데일리 이슈'),
                ),
                IssueListRoot(issueType: IssueType.daily),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
