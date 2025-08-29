import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/domain/entities/reply.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/reply.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../method/date_time_parsing.dart';
import '../../themes/margins_paddings.dart';
import 'user_profile_widget.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final VoidCallback? onLikePressed;
  final VoidCallback? onReplyPressed;
  final VoidCallback? onReportPressed;
  final bool showReplies;
  final VoidCallback? onToggleReplies;

  const ReplyCard({
    super.key,
    required this.reply,
    this.onLikePressed,
    this.onReplyPressed,
    this.onReportPressed,
    this.showReplies = true,
    this.onToggleReplies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MyPaddings.medium, top: MyPaddings.medium, right: MyPaddings.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Profile(width: 32, userProfile: reply.userProfile)),
          SizedBox(width: MyPaddings.medium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyText.reg(
                    reply.userProfile.nickname,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  Text(
                    '•',
                    style: TextStyle(color: AppColors.gray3),
                  ),
                  SizedBox(width: 8),
                  MyText.reg(
                    getTimeAgo(reply.createdAt),
                    color: AppColors.gray2,
                  ),
                ],
              ),
              SizedBox(height: MyPaddings.small),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.articleSmall(
                    reply.content,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: MyPaddings.small),
                  // CommentActions(
                  //   likeCount: reply.likeCount,
                  //   isLiked: reply.isLiked,
                  //   onLikePressed: onLikePressed ?? () {},
                  //   onReplyPressed: onReplyPressed ?? () {},
                  //   onReportPressed: onReportPressed ?? () {},
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}