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
  final bool showReplies;
  final VoidCallback? onToggleReplies;

  const CommentCard({
    super.key,
    required this.comment,
    this.onLikePressed,
    this.onReplyPressed,
    this.onReportPressed,
    this.showReplies = true,
    this.onToggleReplies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MyPaddings.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserProfileWidget(
                userProfile: comment.author,
                size: comment.isReply ? 32 : 40,
              ),
              SizedBox(width: 8),
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
          Padding(
            padding: EdgeInsets.only(left: comment.isReply ? 40 : 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.articleSmall(
                  comment.content,
                  color: AppColors.textPrimary,
                ),
                SizedBox(height: MyPaddings.small),
                CommentActions(
                  likeCount: comment.likeCount,
                  isLiked: comment.isLiked,
                  onLikePressed: onLikePressed ?? () {},
                  onReplyPressed: onReplyPressed ?? () {},
                  onReportPressed: onReportPressed ?? () {},
                ),
              ],
            ),
          ),
          if (comment.replies.isNotEmpty && showReplies) ...[
            SizedBox(height: MyPaddings.small),
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                children: comment.replies.map((reply) {
                  return CommentCard(
                    comment: reply,
                    onLikePressed: () {},
                    onReplyPressed: () {},
                    onReportPressed: () {},
                    showReplies: false,
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}