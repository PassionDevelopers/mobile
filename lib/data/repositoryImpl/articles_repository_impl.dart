import 'package:dio/dio.dart';

import '../../domain/entities/articles.dart';
import '../../domain/repositoryInterfaces/articles_interface.dart';
import '../dto/articles_dto.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final Dio dio;

  ArticlesRepositoryImpl(this.dio);

  @override
  Future<Articles> fetchArticlesByIssueId(String issueId) async {
    final response = await dio.get('/issues/$issueId/articles');
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }

  @override
  Future<Articles> fetchArticlesBySourceId(String sourceId) async {
    final response = await dio.get('/media/$sourceId/articles');
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }

  @override
  Future<Articles> fetchArticlesSubscribed() async {
    final response = await dio.get('/media/subscribed/articles');
    final articlesDTO = ArticlesDTO.fromJson(response.data);
    return articlesDTO.toDomain();
  }
}