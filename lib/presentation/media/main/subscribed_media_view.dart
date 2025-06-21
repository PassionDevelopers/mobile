

import 'package:could_be/core/components/title/big_title_icon.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/media.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_tab_view.dart';

class SubscribedMediaView extends StatelessWidget {
  const SubscribedMediaView({super.key, required this.media});
  final Media media;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.medium, vertical: MyPaddings.small),
          child: BigTitleAdd(title: '관심 매체', onTap: (){

          }),
        ),
        Expanded(
          child: BiasTabView5(
            tabTitles: ['진보', '중도 진보', '중도', '중도 보수', '보수'],
            biasContents: [
              SizedBox(),
              SizedBox(),
              SizedBox(),
              SizedBox(),
              SizedBox(),
            ],
          ),
        ),
        // IssueListView(issueList: media.media.first.recentIssues.issues)
      ],
    );
  }
}
