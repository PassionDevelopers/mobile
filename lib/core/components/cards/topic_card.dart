import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/domain/entities/topic.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_utils.dart';


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
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.small,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.gray4,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: topic.issuesCount == null ? Center(
          child: MyText.reg(
            topic.name,
            color: isSelected
                ? AppColors.primary
                : AppColors.gray1,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.w500,
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
                    : AppColors.gray1,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
            SizedBox(width: MyPaddings.extraSmall),
            // 이슈 수
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: MyPaddings.extraSmall),
                padding: EdgeInsets.all(MyPaddings.extraSmall),
                decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.2)
                        : AppColors.gray5,
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: MyText.reg(
                    '${topic.issuesCount}',
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.gray2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}