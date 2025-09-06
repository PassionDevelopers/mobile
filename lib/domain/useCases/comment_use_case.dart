import 'package:could_be/core/domain/comment_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/domain/entities/comments.dart';
import 'package:could_be/domain/entities/major_comment.dart';
import 'package:could_be/domain/repositoryInterfaces/comment_interface.dart';
import 'package:could_be/presentation/community/comment/comment_state.dart';

class CommentUseCase{
  final CommentRepository commentRepository;

  CommentUseCase(this.commentRepository);

  Future<Result<bool, CommentError>> addComment({required String issueId, required String content, required String? parentCommentId,
    required List<String> source}) async {
    return await commentRepository.addComment(issueId: issueId, content: content, parentCommentId: parentCommentId, source: source);
  }

  Future<void> deleteComment(String commentId) async {
    await commentRepository.deleteComment(commentId);
  }

  Future<void> toggleLikeComment(String commentId) async {
    await commentRepository.toggleLikeComment(commentId);
  }

  Future<Comments> fetchComments({required String issueId, String? lastCommentId, required CommentSortType sortType}) async {
    return await commentRepository.fetchComments(issueId: issueId, lastCommentId: lastCommentId, sortType: sortType);
  }

  Future<List<MajorComment>> fetchMajorComments(String issueId) async {
    return await commentRepository.fetchMajorComments(issueId);
  }

}