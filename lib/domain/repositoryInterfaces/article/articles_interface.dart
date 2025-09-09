
import '../../entities/article/articles.dart';

abstract class ArticlesRepository{

  Future<Articles> fetchArticlesByIssueId(String issueId, {String? lastArticleId});

  Future<Articles> fetchArticlesBySourceId(String sourceId, {String? lastArticleId});

  Future<Articles> fetchArticlesSubscribed({String? lastArticleId});
}