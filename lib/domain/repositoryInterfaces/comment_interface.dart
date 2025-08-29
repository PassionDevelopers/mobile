import 'package:could_be/domain/entities/comments.dart';

abstract class CommentRepository{
  Future<void> addComment({required String issueId, required String content, required String? parentCommentId,
    required List<String> source});

  Future<Comments> fetchComments(String issueId, {String? lastCommentId});

  Future<void> deleteComment(String commentId);

  Future<void> toggleLikeComment(String commentId);
}