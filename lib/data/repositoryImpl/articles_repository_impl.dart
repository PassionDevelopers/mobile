import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/articles.dart';
import '../../domain/repositoryInterfaces/article/articles_interface.dart';
import '../dto/articles_dto.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final Dio dio;

  ArticlesRepositoryImpl(this.dio);

  @override
  Future<Articles> fetchArticlesByIssueId(
    String issueId, {
    String? lastArticleId,
  }) async {
    final response = await dio.get('${ApiVersions.v1}/issues/$issueId/articles');
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }

  @override
  Future<Articles> fetchArticlesBySourceId(
    String sourceId, {
    String? lastArticleId,
  }) async {
    final response = await dio.get(
      '${ApiVersions.v1}/media/$sourceId/articles',
      queryParameters: {'lastArticleId': lastArticleId},
    );
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }

  @override
  Future<Articles> fetchArticlesSubscribed({String? lastArticleId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/media/subscribed/articles',
      queryParameters: {'lastArticleId': lastArticleId},
    );
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }
}
