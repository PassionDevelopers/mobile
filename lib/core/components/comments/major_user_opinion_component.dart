import 'package:could_be/core/components/comments/comment_link.dart';
import 'package:could_be/core/components/popup_menu/popup_menu.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/domain/entities/comment/major_comment.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/margins_paddings.dart';

class MajorUserOpinionComponent extends StatelessWidget {
  const MajorUserOpinionComponent({super.key,
    required this.myBias,
    required this.comment,
    required this.onReportPressed,
    required this.onDeletePressed,
    required this.onLikePressed,
  });
  final Bias? myBias;
  final MajorComment comment;
  final void Function(BuildContext context, String commentId) onReportPressed;
  final void Function(BuildContext context, String commentId) onDeletePressed;
  final void Function(String commentId) onLikePressed;

  _buildLikeButton({required Bias bias, required int likeCount}){
    final bool isLiked = comment.isLiked && bias == myBias;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          Icon(
            isLiked? Icons.thumb_up : Icons.thumb_up_outlined,
            size: 16,
            color: getBiasColor(bias),
          ),
          SizedBox(width: 4),
          MyText.reg(
            likeCount.toString(),
            color: getBiasColor(bias),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMine = FirebaseAuth.instance.currentUser?.uid == comment.userProfile.userId;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Profile(width: 32, userProfile: comment.userProfile),
                SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText.reg(
                        comment.userProfile.nickname,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      MyText.reg(
                        ' • ${getTimeAgo(comment.createdAt)}',
                        color: AppColors.gray600,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 24,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: MyPopupMenu(isMine: isMine, onReportPressed: (){
                      onReportPressed(context, comment.id);
                    }, onDeletePressed: (){
                      onDeletePressed(context, comment.id);
                    },),
                  ),
                )
              ],
            ),
            SizedBox(height: MyPaddings.small),
            MyText.articleSmall(
              comment.isDeleted? '삭제된 댓글입니다.' : comment.content,
              color: comment.isDeleted? AppColors.gray500 : AppColors.textPrimary,
            ),
            SizedBox(height: MyPaddings.medium),
            CommentLink(source: comment.source),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                if(myBias != null){
                  onLikePressed(comment.id);
                }
              },
              child: Row(
                children: [
                  _buildLikeButton(bias: Bias.left, likeCount: comment.leftLikeCount),
                  const SizedBox(width: 16),
                  _buildLikeButton(bias: Bias.center, likeCount: comment.centerLikeCount),
                  const SizedBox(width: 16),
                  _buildLikeButton(bias: Bias.right, likeCount: comment.rightLikeCount),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}