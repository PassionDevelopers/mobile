import 'dart:developer';

import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view_model.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:could_be/core/themes/color.dart';

class CommentInputView extends StatelessWidget {
  const CommentInputView({super.key, required this.issueId, required this.viewModel, required this.commentViewModel});
  final String issueId;
  final CommentInputViewModel viewModel;
  final CommentViewModel commentViewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _){
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[200]!, width: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            // left: MyPaddings.medium,
            // right: MyPaddings.large,
            // top: 8,
            bottom: 8 + MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (viewModel.replyToCommentId != null) _buildReplyIndicator(),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 8),
                  Profile(
                    width: 36,
                    userProfile: viewModel.userProfile
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 120, // 💡 여기서 최대 높이 지정
                          ),
                          child: TextField(
                            controller: viewModel.commentController,
                            focusNode: viewModel.commentFocusNode,
                            maxLines: null,
                            maxLength: 300,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              hintText: viewModel.replyToCommentId != null ? '답글 추가...' : '내 의견 공유하기...',
                              hintStyle: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.gray1,
                            ),
                          ),
                        ),
                        _buildSourceTextBox(),
                      ],
                    ),
                  ),
                  SizedBox(width: 2),
                  _buildSendButton(),
                ],
              ),
              // if (viewModel.isCommentExpanded) _buildInputActions(),
            ],
          ),
        );
      });
  }

  Widget _buildSourceTextBox(){
    return Row(
      children: [
        Icon(Icons.link, size: 16, color: Colors.grey[600]),
        SizedBox(width: 8),
        Expanded(
          child: Form(
            key: viewModel.formKey,
            child: TextFormField(
              controller: viewModel.sourceController,
              maxLines: 1,
              keyboardType: TextInputType.url,
              validator: (value) {
                final uri = Uri.tryParse(value ?? '');
                if (value == null || value.isEmpty) {
                  return null; // 출처 URL은 선택 사항이므로 비어 있어도 유효함
                }
                if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                  return '유효한 URL을 입력해주세요.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '근거 자료 URL 추가 (선택)',
                hintStyle: TextStyle(
                  color: AppColors.gray3,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray1,
              ),
            ),
          )
        ),
      ],
    );
  }

  Widget _buildReplyIndicator() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.reply, size: 16, color: Colors.grey[600]),
          SizedBox(width: 8),
          MyText.reg('${viewModel.replyToUserName}에게 남기는 답글',),
          Spacer(),
          GestureDetector(
            onTap: viewModel.cancelReply,
            child: Icon(Icons.close, size: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    final hasContent = viewModel.hasCommentText;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: IconButton(
        onPressed: hasContent ? (){
          viewModel.sendComment(
            onSuccessReply: commentViewModel.addReply,
              onSuccessComment : commentViewModel.addComment);
        } : null,
        icon: Icon(
          Icons.send,
          color: hasContent ? AppColors.primary : Colors.grey[400],
          size: 20,
        ),
      ),
    );
  }
}