import 'dart:developer';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/reply.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/useCases/comment_use_case.dart';
import 'package:could_be/domain/useCases/manage_user_profile_use_case.dart';
import 'package:flutter/material.dart';

enum CommentSortType {
  newest('최신순'),
  popular('인기순');

  const CommentSortType(this.displayName);
  final String displayName;
}

class CommentViewModel extends ChangeNotifier{

  final CommentUseCase commentUseCase;
  final ManageUserProfileUseCase manageUserProfileUseCase;
  CommentViewModel({required this.commentUseCase, required this.manageUserProfileUseCase, required this.issueId});

  String? parentId;
  final String issueId;
  UserProfile? userProfile;

  // State variables
  List<Comment> _comments = [];
  bool hasMore = false;
  String? lastCommentId;
  CommentSortType _selectedSortType = CommentSortType.newest;

  // Getters
  bool isLoading = false;
  List<Comment> get comments => _comments;
  CommentSortType get selectedSortType => _selectedSortType;

  void initialize() {
    fetchComments();
    setUserProfile();
  }

  // 비즈니스 로직 메서드들

  void setUserProfile()async{
    userProfile = await manageUserProfileUseCase.fetchUserProfile();
    notifyListeners();
  }

  void fetchComments() async {
    try {
      isLoading = true;
      notifyListeners();

      final fetchedComments = await commentUseCase.fetchComments(issueId);
      log('Fetched Comments: ${fetchedComments.comments.length}, Has More: ${fetchedComments.hasMore}');
      _comments = fetchedComments.comments;
      hasMore = fetchedComments.hasMore;
      lastCommentId = fetchedComments.lastCommentId;
      sortComments();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      // 에러 처리 로직
      log('댓글 불러오기 실패: $e');
    }
  }

  void setSortType(CommentSortType sortType) {
    _selectedSortType = sortType;
    sortComments();
  }

  void sortComments() {
    if (_selectedSortType == CommentSortType.newest) {
      _comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      _comments.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    }
    notifyListeners();
  }

  void toggleReplies(String commentId) {
    final commentIndex = _comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = _comments[commentIndex];
      _comments[commentIndex] = comment.copyWith(
        isShowReplies: !comment.isShowReplies,
      );
      notifyListeners();
    }
  }

  void toggleLike(String commentId) {
    final commentIndex = _comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = _comments[commentIndex];
      
      // 답글에서 좋아요 토글 처리
      for (int i = 0; i < _comments.length; i++) {
        final parentComment = _comments[i];
        if (parentComment.replies != null) {
          final replyIndex = parentComment.replies.indexWhere((r) => r.id == commentId);
          if (replyIndex != -1) {
            final reply = parentComment.replies[replyIndex];
            final updatedReplies = List<Reply>.from(parentComment.replies);
            updatedReplies[replyIndex] = reply.copyWith(
              isLiked: !reply.isLiked,
              likeCount: reply.isLiked ? reply.likeCount - 1 : reply.likeCount + 1,
            );
            
            _comments[i] = parentComment.copyWith(
              replies: updatedReplies,
            );
            notifyListeners();
            return;
          }
        }
      }
      
      // 메인 댓글에서 좋아요 토글
      _comments[commentIndex] = comment.copyWith(
        isLiked: !comment.isLiked,
        likeCount: comment.isLiked ? comment.likeCount - 1 : comment.likeCount + 1,
      );
      notifyListeners();
    }
  }

  void addComment(Reply reply) {
    final parentIndex = _comments.indexWhere((c) => c.id == parentId);
    if (parentIndex != -1) {
      final parent = _comments[parentIndex];
      final updatedReplies = List<Reply>.from(parent.replies ?? []);
      updatedReplies.add(reply);

      _comments[parentIndex] = parent.copyWith(
        replies: updatedReplies,
      );
    }
    notifyListeners();
  }

  int getTotalCommentCount() {
    int total = _comments.length;
    for (final comment in _comments) {
      total += comment.replies.length;
    }
    return total;
  }

  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('댓글 신고'),
          content: Text('이 댓글을 신고하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('신고가 접수되었습니다.')),
                );
              },
              child: Text('신고'),
            ),
          ],
        );
      },
    );
  }
}