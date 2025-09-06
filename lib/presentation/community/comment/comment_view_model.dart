import 'dart:developer';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/reply.dart';
import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:could_be/presentation/community/comment/comment_state.dart';
import 'package:could_be/presentation/community/report/report_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CommentViewModel extends ChangeNotifier{

  final CommentUseCase commentUseCase;
  final ManageUserProfileUseCase manageUserProfileUseCase;
  final String issueId;
  CommentViewModel({required this.commentUseCase, required this.manageUserProfileUseCase, required this.issueId}){
    fetchComments();
    setUserProfile();
  }

  late CommentState _state = CommentState(issueId: issueId);
  CommentState get state => _state;

  void setUserProfile()async{
    final profile = await manageUserProfileUseCase.fetchUserProfile();
    _state = state.copyWith(userProfile: profile);
    notifyListeners();
  }

  void fetchComments() async {
    try {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final fetchedComments = await commentUseCase.fetchComments(issueId: issueId, sortType: state.selectedSortType);
      _state = state.copyWith(
        commentsCount: fetchedComments.commentsCount,
        comments: fetchedComments.comments,
        hasMore: fetchedComments.hasMore,
        lastCommentId: fetchedComments.lastCommentId,
      );
      _state = state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    } catch (e) {
      // 에러 처리 로직
      log('댓글 불러오기 실패: $e');
    }
  }

  void fetchMoreComments()async{
    log('hasmore: ${state.hasMore}, isLoadingMore: ${state.isLoadingMore}, isLoading: ${state.isLoading}, commentsLength: ${state.comments.length}');
    if(state.isLoadingMore || state.isLoading || !state.hasMore || state.comments.length >= 300) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();

    final fetchedComments = await commentUseCase.fetchComments(issueId: issueId, lastCommentId: state.lastCommentId, sortType: state.selectedSortType);
    _state = state.copyWith(
      comments: state.comments + fetchedComments.comments,
      hasMore: fetchedComments.hasMore,
      lastCommentId: fetchedComments.lastCommentId,
    );
    _state = state.copyWith(isLoadingMore: false);
    notifyListeners();
  }

  void deleteComment(String commentId)async{
    state.comments.removeWhere((c) => c.id == commentId);
    await commentUseCase.deleteComment(commentId);
    notifyListeners();
  }

  void deleteReply(String commentId, String replyId) async {
    final commentIndex = state.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = state.comments[commentIndex];
      final updatedReplies = List<Reply>.from(comment.replies)..removeWhere((r) => r.id == replyId);
      state.comments[commentIndex] = comment.copyWith(
        replies: updatedReplies,
      );
      notifyListeners();
      await commentUseCase.deleteComment(replyId);
    }
  }

  void onReportSuccess(String commentId) {
    state.comments.removeWhere((c) => c.id == commentId);
    notifyListeners();
  }

  void showDeleteConfirmDialog(BuildContext context, String commentId, {String? replyId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('댓글 삭제'),
          content: Text('이 댓글을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if(replyId != null) {
                  deleteReply(commentId, replyId);
                }else{
                  deleteComment(commentId);
                }
              },
              child: Text('삭제', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void checkIsMyComment() {
    // final commentIndex = _comments.indexWhere((c) => c.id == commentId);
    // if (commentIndex != -1) {
    //   final comment = _comments[commentIndex];
    //   _comments[commentIndex] = comment.copyWith(
    //     isMyComment: true,
    //   );
    //   notifyListeners();
    // }
  }

  void setSortType(CommentSortType sortType) {
    _state = state.copyWith(selectedSortType: sortType);
    fetchComments();
  }

  void toggleReplies(String commentId) {
    final commentIndex = state.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = state.comments[commentIndex];
      state.comments[commentIndex] = comment.copyWith(
        isShowReplies: !comment.isShowReplies,
      );
      notifyListeners();
    }
  }

  void toggleLike({required String commentId, String? replyId}) {
    final commentIndex = state.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = state.comments[commentIndex];

      if(replyId != null){
        // 답글에서 좋아요 토글 처리
        for (int i = 0; i < state.comments.length; i++) {
          final parentComment = state.comments[i];
          final replyIndex = parentComment.replies.indexWhere((r) => r.id == replyId);
          if (replyIndex != -1) {
            final reply = parentComment.replies[replyIndex];
            final updatedReplies = List<Reply>.from(parentComment.replies);
            updatedReplies[replyIndex] = reply.copyWith(
              isLiked: !reply.isLiked,
              likeCount: reply.isLiked ? reply.likeCount - 1 : reply.likeCount + 1,
            );
            state.comments[i] = parentComment.copyWith(
              replies: updatedReplies,
            );
            notifyListeners();
            commentUseCase.toggleLikeComment(replyId);
          }
        }
      }else{
        // 메인 댓글에서 좋아요 토글
        state.comments[commentIndex] = comment.copyWith(
          isLiked: !comment.isLiked,
          likeCount: comment.isLiked ? comment.likeCount - 1 : comment.likeCount + 1,
        );
        commentUseCase.toggleLikeComment(commentId);
        notifyListeners();
      }
    }
  }

  void addReply(String commentId, Reply reply) {
    final commentIndex = state.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = state.comments[commentIndex];
      final updatedReplies = List<Reply>.from(comment.replies);
      final comments = List<Comment>.from(state.comments);
      comments[commentIndex] = comment.copyWith(
        replies: updatedReplies,
        isShowReplies: true, // 답글이 추가되면 답글 목록을 보여줌
      );

      updatedReplies.add(reply);
      _state = state.copyWith(
        comments: comments
      );
      notifyListeners();
    }
  }


  void addComment(Comment comment) {
    state.comments.insert(0, comment);
    notifyListeners();
  }

  int getTotalCommentCount() {
    int total = state.comments.length;
    for (final comment in state.comments) {
      total += comment.replies.length;
    }
    return total;
  }

  void showReportDialog(BuildContext context, String commentId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReportBottomSheet(
          commentId: commentId,
          onReportSuccess: () {
            onReportSuccess(commentId);
          },
        );
      },
    );
  }
}