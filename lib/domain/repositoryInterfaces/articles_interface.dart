
import '../entities/articles.dart';

abstract class ArticlesRepository{

  Future<Articles> fetchArticlesByIssueId(String issueId);

  Future<Articles> fetchArticlesBySourceId(String sourceId);

  Future<Articles> fetchArticlesSubscribed();
}