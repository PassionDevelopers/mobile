import 'package:could_be/domain/entities/comments.dart';
import 'package:could_be/domain/repositoryInterfaces/comment_interface.dart';

class CommentUseCase{
  final CommentRepository commentRepository;

  CommentUseCase(this.commentRepository);

  Future<void> addComment({required String issueId, required String content, required String? parentCommentId,
    required List<String> source}) async {
    await commentRepository.addComment(issueId: issueId, content: content, parentCommentId: parentCommentId, source: source);
  }

  Future<void> deleteComment(String commentId) async {
    await commentRepository.deleteComment(commentId);
  }

  Future<void> toggleLikeComment(String commentId) async {
    await commentRepository.toggleLikeComment(commentId);
  }

  Future<Comments> fetchComments(String issueId, {String? lastCommentId}) async {
    return await commentRepository.fetchComments(issueId, lastCommentId: lastCommentId);
  }

}