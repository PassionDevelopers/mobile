
import 'package:could_be/core/error/comment_error.dart';
import 'package:could_be/core/error/result.dart';
import 'package:could_be/domain/entities/comment/comments.dart';
import 'package:could_be/domain/entities/comment/major_comment.dart';
import 'package:could_be/presentation/community/comment/comment_state.dart';

abstract class CommentRepository{

  Future<Result<bool, CommentError>> addComment({required String issueId, required String content, required String? parentCommentId,
    required List<String> source});

  Future<Comments> fetchComments({required String issueId, String? lastCommentId, required CommentSortType sortType});

  Future<void> deleteComment(String commentId);

  Future<void> toggleLikeComment(String commentId);

  Future<List<MajorComment>> fetchMajorComments(String issueId);

}