import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class CommentActions extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onReplyPressed;
  final VoidCallback onReportPressed;

  const CommentActions({
    super.key,
    required this.likeCount,
    required this.isLiked,
    required this.onLikePressed,
    required this.onReplyPressed,
    required this.onReportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onLikePressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 16,
                  color: isLiked ? AppColors.right : AppColors.gray2,
                ),
                if (likeCount > 0) ...[
                  SizedBox(width: 4),
                  MyText.reg(
                    likeCount.toString(),
                    color: isLiked ? AppColors.right : AppColors.gray2,
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: onReplyPressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 16,
                  color: AppColors.gray2,
                ),
                SizedBox(width: 4),
                MyText.reg(
                  '답글',
                  color: AppColors.gray2,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: onReportPressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Icon(
                  Icons.report_outlined,
                  size: 16,
                  color: AppColors.gray2,
                ),
                SizedBox(width: 4),
                MyText.reg(
                  '신고',
                  color: AppColors.gray2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}