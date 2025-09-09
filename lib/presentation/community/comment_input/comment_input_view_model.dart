import 'dart:developer';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/error/comment_error.dart';
import 'package:could_be/core/error/result.dart';
import 'package:could_be/domain/entities/comment/comment.dart';
import 'package:could_be/domain/entities/comment/reply.dart';
import 'package:could_be/domain/entities/user/user_profile.dart';
import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/user/manage_user_profile_use_case.dart';
import 'package:flutter/material.dart';

class CommentInputViewModel extends ChangeNotifier {
  final ManageUserProfileUseCase manageUserProfileUseCase;
  final CommentUseCase commentUseCase;

  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController sourceController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();

  int currentSourceLength = 1;
  bool _isCommentExpanded = false;
  String? _replyToCommentId;
  String? _replyToUserName;
  UserProfile? userProfile;

  final String issueId;

  CommentInputViewModel({
    required this.manageUserProfileUseCase,
    required this.commentUseCase,
    required this.issueId,
  }) {
    setUserProfile();
    commentFocusNode.addListener(_onFocusChanged);
    commentController.addListener(_onTextChanged);
  }

  bool get isCommentExpanded => _isCommentExpanded;

  String? get replyToCommentId => _replyToCommentId;

  String? get replyToUserName => _replyToUserName;

  bool get hasCommentText => commentController.text.trim().isNotEmpty;

  @override
  void dispose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  void setUserProfile() async {
    userProfile = await manageUserProfileUseCase.fetchUserProfile();
    notifyListeners();
  }

  void _onFocusChanged() {
    _isCommentExpanded = commentFocusNode.hasFocus;
    notifyListeners();
  }

  void _onTextChanged() {
    notifyListeners();
  }

  void startReply(String commentId, String userName) {
    _replyToCommentId = commentId;
    _replyToUserName = userName;
    commentFocusNode.requestFocus();
    notifyListeners();
  }

  void cancelReply() {
    _replyToCommentId = null;
    _replyToUserName = null;
    notifyListeners();
  }

  void sendComment({
    required void Function(Comment comment) onSuccessComment,
    required void Function(String parentId, Reply reply) onSuccessReply,
  }) async {
    final content = commentController.text.trim();
    final source = sourceController.text.trim();
    if (content.isEmpty || userProfile == null) return;

    if(source.isNotEmpty && (formKey.currentState ==null || !formKey.currentState!.validate())) return;

    commentController.clear();
    sourceController.clear();
    commentFocusNode.unfocus();

    final result = await commentUseCase.addComment(
      issueId: issueId,
      content: content,
      parentCommentId: _replyToCommentId,
      source: [if(source.isNotEmpty)source],
    );
    switch (result) {
      case ResultSuccess<bool, CommentError> success:
        if(_replyToCommentId != null) {
          log('Reply added successfully: ${userProfile?.userId}');
          onSuccessReply(
            _replyToCommentId!,
            Reply(
              id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
              content: content,
              createdAt: DateTime.now(),
              likeCount: 0,
              userProfile: userProfile!,
              source: [if(source.isNotEmpty)source],
              isLiked: false,
              isDeleted: false,
            ),
          );
          return;
        }else{
          onSuccessComment(
            Comment(
              id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
              content: content,
              createdAt: DateTime.now(),
              likeCount: 0,
              userProfile: userProfile!,
              isLiked: false,
              replies: [],
              isShowReplies: false,
              source: [if(source.isNotEmpty)source],
              isDeleted: false,
            ),
          );
        }
      case ResultError<bool, CommentError> error:
        showMyToast(msg: error.error.toString());
    }

    cancelReply();
  }

  void cancelComment() {
    commentController.clear();
    commentFocusNode.unfocus();
    cancelReply();
  }
}
