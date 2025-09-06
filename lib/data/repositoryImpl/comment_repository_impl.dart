
import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/core/domain/comment_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/data/dto/comments_dto.dart';
import 'package:could_be/data/dto/major_comment_dto.dart';
import 'package:could_be/domain/entities/comments.dart';
import 'package:could_be/domain/entities/major_comment.dart';
import 'package:could_be/domain/repositoryInterfaces/comment_interface.dart';
import 'package:could_be/presentation/community/comment/comment_state.dart';
import 'package:dio/dio.dart';

class CommentRepositoryImpl extends CommentRepository {
  final Dio dio;

  CommentRepositoryImpl(this.dio);

  @override
  Future<Result<bool, CommentError>> addComment(
      {required String issueId, required String content, required String? parentCommentId,
        required List<String> source}) async {
      final response = await dio.post(
          '${ApiVersions.v1}/comments/issues/$issueId',
          data: {
            'content': content,
            if(parentCommentId != null) 'parentCommentId': parentCommentId,
            'source': source,
          }
      ).onError((DioException e, stackTrace) {
        return e.response ?? Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode ?? 999,
        );
      });

      switch(response.statusCode) {
        case 200:
          return Result.success(true);
        case 400:
          return Result.error(CommentError.notProper);
        default:
          return Result.error(CommentError.unknown);
      }
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
  Future<Comments> fetchComments({required String issueId, String? lastCommentId, required CommentSortType sortType}) async {
    final response = await dio.get(
        '${ApiVersions.v1}/comments/issues/$issueId',
      queryParameters: {
        if(lastCommentId != null) 'lastCommentId': lastCommentId,
        'sort_by' : sortType.name
      }
    );
    final CommentsDto commentsDto = CommentsDto.fromJson(response.data);
    return commentsDto.toDomain();
  }

  @override
  Future<List<MajorComment>> fetchMajorComments(String issueId)async{
    final response = await dio.get(
        '${ApiVersions.v1}/comments/issues/$issueId/major'
    );
    final List a = response.data['comments'];
    final List<MajorCommentDto> majorCommentDtos = a.map((e) => MajorCommentDto.fromJson(e)).toList();
    return majorCommentDtos.map((e) => e.toDomain()).toList();
  }

}