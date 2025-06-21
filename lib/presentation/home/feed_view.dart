import 'package:flutter/material.dart';

import '../../../core/components/chips/issue_chip.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../core/themes/margins_paddings.dart';
import '../issue_list/main/issue_list_root.dart';
import '../issue_list/issue_type.dart';

class FeedView extends StatelessWidget {
  final void Function(String issueId) onIssueSelected;

  FeedView({super.key, required this.onIssueSelected});

  final List<String> issueCategories = [
    '데일리 이슈',
    '추천 이슈',
    '경제',
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
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: MyPaddings.small),
                child: StatefulBuilder(
                  builder: (context, setChipState) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
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
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                    vertical: MyPaddings.small,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('데일리 이슈', style: MyFontStyle.h1,),
                  ),
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
