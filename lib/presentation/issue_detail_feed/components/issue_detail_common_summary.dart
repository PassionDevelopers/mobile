import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/cards/issue_detail_title_card.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

import 'move_to_next_button.dart' show MoveToNextButton;

class IssueDetailCommonSummary extends StatelessWidget {
  const IssueDetailCommonSummary({
    super.key,
    required this.commonSummary,
    required this.fontSize,
    required this.moveToNextPage,
  });

  final String commonSummary;
  final double fontSize;
  final VoidCallback moveToNextPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IssueDetailTitleCard(
          icon: Icon(Icons.join_inner),
          title: BigTitle(title: '공통 보도 내용'),
        ),
        SizedBox(height: MyPaddings.medium),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Column(
            children: [
              TextCard(
                color: AppColors.primary,
                child: parseAiText(commonSummary, fontSize, AppColors.gray1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
