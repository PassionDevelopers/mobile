import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:flutter/material.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';

class CommentActions extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final String commentId;
  final String? replyId;
  final Bias bias;
  final void Function({required String commentId, String? replyId})? onLikePressed;
  final VoidCallback? onReplyPressed;

  const CommentActions({
    super.key,
    required this.bias,
    required this.commentId,
    this.replyId,
    required this.likeCount,
    required this.isLiked,
    this.onLikePressed,
    this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(onLikePressed != null)InkWell(
          onTap: (){
            if(replyId != null){
              onLikePressed!(commentId: commentId, replyId: replyId!);
            }else{
              onLikePressed!(commentId: commentId);
            }
          },
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 16,
                  color: isLiked ? getBiasColor(bias) : AppColors.gray2,
                ),
                if (likeCount > 0) ...[
                  SizedBox(width: 4),
                  MyText.reg(
                    likeCount.toString(),
                    color: isLiked ? getBiasColor(bias) : AppColors.gray2,
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        if(onReplyPressed != null)InkWell(
          onTap: onReplyPressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: MyText.reg(
              '답글 달기',
              color: AppColors.gray2,
            ),
          ),
        ),
      ],
    );
  }
}