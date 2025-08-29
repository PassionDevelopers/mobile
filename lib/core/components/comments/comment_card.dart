import 'package:could_be/core/components/comments/reply_card.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/comment.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../method/date_time_parsing.dart';
import '../../themes/margins_paddings.dart';
import 'comment_actions.dart';
import 'user_profile_widget.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onLikePressed;
  final VoidCallback? onReplyPressed;
  final VoidCallback? onReportPressed;
  final VoidCallback onToggleReplies;

  const CommentCard({
    super.key,
    required this.comment,
    this.onLikePressed,
    this.onReplyPressed,
    this.onReportPressed,
    required this.onToggleReplies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MyPaddings.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
              child: Profile(width: 32, userProfile: comment.userProfile)),
          SizedBox(width: MyPaddings.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyText.reg(
                      comment.userProfile.nickname,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    Text(
                      '•',
                      style: TextStyle(color: AppColors.gray3),
                    ),
                    SizedBox(width: 8),
                    MyText.reg(
                      getTimeAgo(comment.createdAt),
                      color: AppColors.gray2,
                    ),
                  ],
                ),
                SizedBox(height: MyPaddings.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.articleSmall(
                      comment.isDeleted? '삭제된 댓글입니다.' : comment.content,
                      color: comment.isDeleted? AppColors.gray3 : AppColors.textPrimary,
                    ),
                    SizedBox(height: MyPaddings.small),
                    CommentActions(
                      likeCount: comment.likeCount,
                      isLiked: comment.isLiked,
                      onLikePressed: onLikePressed ?? () {},
                      onReplyPressed: onReplyPressed ?? () {},
                      onReportPressed: onReportPressed ?? () {},
                    ),
                    if (comment.replies.isNotEmpty) ...[
                      SizedBox(height: MyPaddings.small),
                      Row(
                        children: [
                          Container(height: 0.5, color: AppColors.gray3, width: 25),
                          SizedBox(width: MyPaddings.medium),
                          GestureDetector(
                            onTap: onToggleReplies,
                            child: MyText.reg(
                              comment.isShowReplies
                                  ? '답글 숨기기'
                                  : '답글 ${comment.replies.length}개 더 보기',
                              fontWeight: FontWeight.w800,
                              color: AppColors.gray2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                if (comment.replies.isNotEmpty && comment.isShowReplies) ...[
                  Column(
                    children: comment.replies.map((reply) {
                      return ReplyCard(reply: reply);
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}