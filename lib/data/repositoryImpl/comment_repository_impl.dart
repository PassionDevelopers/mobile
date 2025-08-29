import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/dto/comments_dto.dart';
import 'package:could_be/domain/entities/comments.dart';
import 'package:could_be/domain/repositoryInterfaces/comment_interface.dart';
import 'package:dio/dio.dart';

class CommentRepositoryImpl extends CommentRepository {
  final Dio dio;

  CommentRepositoryImpl(this.dio);

  @override
  Future<void> addComment(
      {required String issueId, required String content, required String? parentCommentId,
        required List<String> source}) async {
    final response = await dio.post(
        '${ApiVersions.v1}/comments/issues/$issueId',
      data: {
        'content': content,
        if(parentCommentId != null) 'parentCommentId': parentCommentId,
        'source': source,
      }
    );
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final response = await dio.delete(
        '${ApiVersions.v1}/comments/$commentId'
    );
  }

  @override
  Future<void> toggleLikeComment(String commentId) async {
    final response = await dio.post(
        '${ApiVersions.v1}/comments/$commentId/like'
    );
  }

  @override
  Future<Comments> fetchComments(String issueId, {String? lastCommentId}) async {
    final response = await dio.get(
        '${ApiVersions.v1}/comments/issues/$issueId',
      queryParameters: {
        if(lastCommentId != null) 'lastCommentId': lastCommentId,
      }
    );
    final CommentsDto commentsDto = CommentsDto.fromJson(response.data);
    return commentsDto.toDomain();
  }

}