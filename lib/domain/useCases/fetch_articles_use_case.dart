
import '../entities/articles.dart';
import '../repositoryInterfaces/articles_interface.dart';

class FetchArticlesUseCase {
  final ArticlesRepository _articlesRepository;

  FetchArticlesUseCase(this._articlesRepository);

  Future<Articles> fetchArticlesBySourceId(String sourceId) async {
    return await _articlesRepository.fetchArticlesBySourceId(sourceId);
  }

  Future<Articles> fetchArticlesByIssueId(String issueId) async {
    return await _articlesRepository.fetchArticlesByIssueId(issueId);
  }

  Future<Articles> fetchArticlesSubscribed() async {
    return await _articlesRepository.fetchArticlesSubscribed();
  }
}