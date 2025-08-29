import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:flutter/material.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/entities/comment.dart';

class CommentInputViewModel extends ChangeNotifier {
  final ManageUserProfileUseCase manageUserProfileUseCase;
  final CommentUseCase commentUseCase;
  
  final TextEditingController commentController = TextEditingController();
  final TextEditingController sourceContoller = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  
  bool _isCommentExpanded = false;
  String? _replyToCommentId;
  String? _replyToUserName;
  UserProfile? userProfile;

  final String issueId;
  String? parentId;

  CommentInputViewModel({required this.manageUserProfileUseCase, required this.commentUseCase, required this.issueId}) {
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

  void setUserProfile()async{
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

  void sendComment()async{
    final content = commentController.text.trim();
    if (content.isEmpty || userProfile == null) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      createdAt: DateTime.now(),
      likeCount: 0,
      isLiked: false,
      userProfile: userProfile!
      // parentId: _replyToCommentId,
    );

    await commentUseCase.addComment(issueId: issueId, content: content, parentCommentId: parentId, source: []);

    commentController.clear();
    cancelReply();
    commentFocusNode.unfocus();
  }

  void cancelComment() {
    commentController.clear();
    commentFocusNode.unfocus();
    cancelReply();
  }
}