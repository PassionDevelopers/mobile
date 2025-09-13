import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:flutter/material.dart';

import '../../themes/color.dart';
import '../../themes/fonts.dart';
import '../../themes/margins_paddings.dart';


class TopicCard extends StatelessWidget {
  const TopicCard({super.key,
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  final Topic topic;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Ink(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.gray400,
            width: 1,
          ),
        ),
        child: topic.issuesCount == null ? Center(
          child: MyText.reg(
            topic.name,
            color: isSelected
                ? AppColors.primary
                : AppColors.gray700,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.w500,
            maxLines: 2, minFontSize: 1
          ),
        ) :
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 토픽 이름
            Expanded(
              flex: 2,
              child: MyText.reg(
                topic.name,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.gray700,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
                maxLines: 2, minFontSize: 1
              ),
            ),
            SizedBox(width: MyPaddings.small),
            // 이슈 수
            MyText.small(
              '${topic.issuesCount}',
              color: isSelected
                  ? AppColors.gray700
                  : AppColors.gray400,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}