
import 'dart:io';

import 'package:could_be/core/domain/network_error.dart';
import 'package:could_be/core/domain/result.dart';

import '../entities/articles.dart';
import '../repositoryInterfaces/articles_interface.dart';

class FetchArticlesUseCase {
  final ArticlesRepository _articlesRepository;

  FetchArticlesUseCase(this._articlesRepository);

  Future<Articles> fetchArticlesBySourceId(String sourceId, {String? lastArticleId}) async {
    return await _articlesRepository.fetchArticlesBySourceId(sourceId, lastArticleId: lastArticleId);
  }

  Future<Articles> fetchArticlesByIssueId(String issueId, {String? lastArticleId}) async {
    return await _articlesRepository.fetchArticlesByIssueId(issueId, lastArticleId: lastArticleId);
  }

  Future<Result<Articles, NetworkError>> fetchArticlesSubscribed({String? lastArticleId}) async {
    try {
      final articles = await _articlesRepository.fetchArticlesSubscribed(lastArticleId: lastArticleId);
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