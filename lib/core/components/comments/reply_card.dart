import 'package:could_be/core/components/comments/comment_actions.dart';
import 'package:could_be/core/components/comments/comment_link.dart';
import 'package:could_be/core/components/popup_menu/popup_menu.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/domain/entities/reply.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../method/date_time_parsing.dart';
import '../../themes/margins_paddings.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final String commentId;
  final void Function({required String commentId, String? replyId}) onLikePressed;
  final void Function(BuildContext context, String commentId) onReportPressed;
  final void Function(BuildContext context, String commentId, {String? replyId}) onDeletePressed;

  const ReplyCard({
    super.key,
    required this.reply,
    required this.commentId,
    required this.onLikePressed,
    required this.onReportPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMine = reply.userProfile.userId == FirebaseAuth.instance.currentUser?.uid;
    return Container(
      padding: EdgeInsets.only(bottom: MyPaddings.medium, top: MyPaddings.medium, right: MyPaddings.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Profile(width: 32, userProfile: reply.userProfile),
              SizedBox(width: MyPaddings.medium),
              MyText.reg(
                reply.userProfile.nickname,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              MyText.reg(' • ', color: AppColors.gray3),
              MyText.reg(
                getTimeAgo(reply.createdAt),
                color: AppColors.gray2,
              ),
              Spacer(),
              Expanded(
                child: MyPopupMenu(isMine: isMine,
                  onDeletePressed: (){onDeletePressed(context, commentId, replyId: reply.id);},
                  onReportPressed: (){onReportPressed(context, reply.id);},
                ),
              )
            ],
          ),

          Row(
            children: [
              SizedBox(width: 32,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.articleSmall(
                    reply.isDeleted? '삭제된 댓글입니다.' : reply.content,
                    color: reply.isDeleted? AppColors.gray3 : AppColors.textPrimary,
                  ),
                  SizedBox(height: MyPaddings.medium),
                  CommentLink(source: reply.source),
                  SizedBox(height: MyPaddings.medium),
                  CommentActions(
                    commentId: commentId,
                    replyId: reply.id,
                    bias: reply.userProfile.bias,
                    onLikePressed: onLikePressed,
                    likeCount: reply.likeCount,
                    isLiked: reply.isLiked
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}