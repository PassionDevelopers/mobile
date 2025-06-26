
import 'dart:io';

import 'package:could_be/core/domain/network_error.dart';
import 'package:could_be/core/domain/result.dart';

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

  Future<Result<Articles, NetworkError>> fetchArticlesSubscribed() async {
    try {
      final articles = await _articlesRepository.fetchArticlesSubscribed();
      return Result.success(articles);
    } on SocketException catch (e) {
      return Result.error(NetworkError.noInternetConnection);
    // } on HttpException catch (e) {
    //   return Result.error(NetWorkError.fromException(e));
    // } on FormatException catch (e) {
    //   return Result.error(NetWorkError.fromException(e));
    } catch (e) {
      return Result.error(NetworkError.unknown);
    }

  }
}