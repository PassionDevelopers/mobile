import 'package:could_be/core/method/bias/bias_enum.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gray5,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.join_inner,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: MyPaddings.medium),
                Text(
                  '공통 보도 내용',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MyPaddings.large),
            child: parseAiText(commonSummary, fontSize, AppColors.gray1),
          ),
        ],
      ),
    );
  }
}
