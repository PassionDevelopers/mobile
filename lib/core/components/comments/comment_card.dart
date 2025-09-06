import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/components/comments/comment_link.dart';
import 'package:could_be/core/components/comments/reply_card.dart';
import 'package:could_be/core/components/popup_menu/popup_menu.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/comment.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../method/date_time_parsing.dart';
import '../../themes/margins_paddings.dart';
import 'comment_actions.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final bool isMine;
  final void Function({required String commentId, String? replyId}) onLikePressed;
  final VoidCallback? onReplyPressed;
  final void Function(BuildContext context, String commentId) onReportPressed;
  final void Function(BuildContext context, String commentId, {String? replyId}) onDeletePressed;
  final VoidCallback onToggleReplies;

  const CommentCard({
    super.key,
    required this.comment,
    required this.isMine,
    required this.onLikePressed,
    this.onReplyPressed,
    required this.onReportPressed,
    required this.onDeletePressed,
    required this.onToggleReplies,
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
              Profile(width: 32, userProfile: comment.userProfile),
              SizedBox(width: MyPaddings.medium),
              MyText.reg(
                comment.userProfile.nickname,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              MyText.reg(' • ', color: AppColors.gray3),
              MyText.reg(
                getTimeAgo(comment.createdAt),
                color: AppColors.gray2,
              ),
              Spacer(),
              MyPopupMenu(isMine: isMine, onReportPressed: (){
                onReportPressed(context, comment.id);
              }, onDeletePressed: (){
                onDeletePressed(context, comment.id);
              },)
            ],
          ),

          Row(
            children: [
              SizedBox(width: 32,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.articleSmall(
                    comment.isDeleted? '삭제된 댓글입니다.' : comment.content,
                    color: comment.isDeleted? AppColors.gray3 : AppColors.textPrimary,
                  ),
                  SizedBox(height: MyPaddings.medium),
                  CommentLink(source: comment.source),
                  SizedBox(height: MyPaddings.medium),
                  CommentActions(
                    bias: comment.userProfile.bias,
                    commentId: comment.id,
                    likeCount: comment.likeCount,
                    isLiked: comment.isLiked,
                    onLikePressed: onLikePressed,
                    onReplyPressed: onReplyPressed ?? () {},
                  ),
                  if (comment.replies.isNotEmpty) ...[
                    SizedBox(height: MyPaddings.medium),
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
                  if (comment.replies.isNotEmpty && comment.isShowReplies) ...[
                    Column(
                      children: comment.replies.map((reply) {
                        return ReplyCard(
                          commentId: comment.id,
                          reply: reply,
                          onLikePressed: onLikePressed,
                          onDeletePressed: onDeletePressed,
                          onReportPressed: onReportPressed,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}