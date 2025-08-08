import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/components/cards/issue_detail_title_card.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import 'move_to_next_button.dart' show MoveToNextButton;

class IssueDetailCommonSummary extends StatelessWidget {
  const IssueDetailCommonSummary({
    super.key,
    required this.commonSummary,
    required this.fontSize,
    required this.isSpread,
    required this.spreadCallback,
  });

  final String commonSummary;
  final double fontSize;
  final bool isSpread;
  final VoidCallback spreadCallback;

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
            child: InkWell(
              onTap: spreadCallback,
              child: Ink(
                child: Row(
                  children: [
                    Icon(
                      Icons.join_inner,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    SizedBox(width: MyPaddings.medium),
                    MyText.h2(
                      '공통 보도 내용',
                      color: AppColors.primary,
                    ),
                    Spacer(),
                    Icon(isSpread? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
          ),
          isSpread? Padding(
            padding: EdgeInsets.all(MyPaddings.large),
            child: parseAiText(commonSummary, fontSize, AppColors.gray1, Colors.amberAccent),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
