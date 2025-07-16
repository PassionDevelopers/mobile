import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/events/media_subscription_events.dart';
import 'package:could_be/domain/entities/article.dart' show Article;
import 'package:could_be/domain/useCases/fetch_articles_use_case.dart';
import 'package:could_be/domain/useCases/fetch_sources_use_case.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/domain/network_error.dart';
import '../../../core/domain/result.dart';
import '../../../domain/entities/articles.dart';
import 'subscribed_media_state.dart';

class SubscribedMediaViewModel with ChangeNotifier {
  final FetchSourcesUseCase _fetchSourcesUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;

  //단발성 에러 처리
  final _eventController = StreamController<NetworkError>();

  Stream<NetworkError> get eventStream => _eventController.stream;

  // Media subscription stream subscriptions
  StreamSubscription<String>? _subscriptionStreamSubscription;
  StreamSubscription<String>? _unsubscriptionStreamSubscription;

  SubscribedMediaState _state = SubscribedMediaState();

  SubscribedMediaState get state => _state;

  SubscribedMediaViewModel({
    required FetchSourcesUseCase fetchSourcesUseCase,
    required FetchArticlesUseCase fetchArticlesUseCase,
  }) : _fetchSourcesUseCase = fetchSourcesUseCase,
       _fetchArticlesUseCase = fetchArticlesUseCase {
    _fetchSubscribedSources();
    fetchCommonArticles();
    _setupSubscriptionListeners();
  }

  void refreshArticles() {
    if (state.selectedSourceId == null) {
      fetchCommonArticles();
    } else {
      fetchSpecificSourceArticles(state.selectedSourceId!);
    }
  }

  void setSelectedSourceId(String sourceId) {
    if (sourceId == _state.selectedSourceId) {
      _state = state.copyWith(selectedSourceId: null);
      fetchCommonArticles();
    } else {
      _state = state.copyWith(selectedSourceId: sourceId);
      fetchSpecificSourceArticles(sourceId);
    }
  }

  void fetchMoreIssues({required String? lastArticleId}) async {
    if(lastArticleId == null) return;
    if(_state.isLoadingMore || !_state.articles!.hasMore || _state.articles!.articles.length >=50) return;

    _state = state.copyWith(isLoadingMore: true, selectedSourceId: state.selectedSourceId);
    notifyListeners();

    if(state.selectedSourceId == null) {
      final result = await _fetchArticlesUseCase.fetchArticlesSubscribed(lastArticleId: lastArticleId);
      switch (result) {
        case ResultSuccess<Articles, NetworkError> success:
          addMoreLoadedArticles(result.data);
        case ResultError<Articles, NetworkError>():
          switch (result.error) {
            case NetworkError.requestTimeout:
            case NetworkError.noInternetConnection:
            case NetworkError.serverError:
            case NetworkError.unknown:
          }
          _eventController.add(result.error);
      }
    }else{
      final result = await _fetchArticlesUseCase.fetchArticlesBySourceId(state.selectedSourceId!, lastArticleId: lastArticleId);
      addMoreLoadedArticles(result);
    }
  }

  void addMoreLoadedArticles(Articles newArticles) {
    if (newArticles.articles.isEmpty) return;

    List<Article> newArticleList = state.articles!.articles + newArticles.articles;
    if(newArticleList.length > 50) {
      newArticleList = newArticleList.sublist(newArticleList.length-50);
    }
    _state = state.copyWith(
      articles: Articles(
        articles: newArticleList,
        hasMore: newArticles.hasMore,
        lastArticleId: newArticles.lastArticleId,
      ),
      isLoadingMore: false, selectedSourceId: state.selectedSourceId,
    );
    notifyListeners();
  }

  void _fetchSubscribedSources() async {
    _state = state.copyWith(
      isSourcesLoading: true,
      selectedSourceId: state.selectedSourceId,
    );
    notifyListeners();

    final result = await _fetchSourcesUseCase.fetchSubscribedSources();
    _state = state.copyWith(
      sources: result,
      isSourcesLoading: false,
      selectedSourceId: state.selectedSourceId,
    );

    notifyListeners();
  }

  void fetchSpecificSourceArticles(String sourceId, {String? lastArticleId}) async {
    _state = state.copyWith(
      isArticlesLoading: true,
      selectedSourceId: state.selectedSourceId,
    );
    notifyListeners();

    final result = await _fetchArticlesUseCase.fetchArticlesBySourceId(
      sourceId,
    );
    _state = state.copyWith(
      articles: result,
      isArticlesLoading: false,
      selectedSourceId: state.selectedSourceId,
    );

    notifyListeners();
  }

  void fetchCommonArticles() async {
    _state = state.copyWith(
      isArticlesLoading: true,
      selectedSourceId: state.selectedSourceId,
    );
    notifyListeners();

    final result = await _fetchArticlesUseCase.fetchArticlesSubscribed();
    switch (result) {
      case ResultSuccess<Articles, NetworkError> success:
        _state = state.copyWith(
          selectedSourceId: state.selectedSourceId,
          articles: result.data,
          isArticlesLoading: false,
        );
        notifyListeners();
      case ResultError<Articles, NetworkError>():
        switch (result.error) {
          case NetworkError.requestTimeout:
          case NetworkError.noInternetConnection:
          case NetworkError.serverError:
          case NetworkError.unknown:
        }
        _eventController.add(result.error);
    }
  }

  void _setupSubscriptionListeners() {
    _subscriptionStreamSubscription = MediaSubscriptionEvents.subscriptionStream.listen(
      (sourceId) {
        _fetchSubscribedSources();
        if (state.selectedSourceId == sourceId) {
          return;
        }
        if (state.selectedSourceId == null) {
          fetchCommonArticles();
        } else {
          fetchSpecificSourceArticles(sourceId);
        }
      },
    );

    _unsubscriptionStreamSubscription = MediaSubscriptionEvents.unsubscriptionStream.listen(
      (sourceId) {
        _fetchSubscribedSources();
        if(state.selectedSourceId == sourceId) {
          _state = state.copyWith(selectedSourceId: null);
          notifyListeners();
          fetchCommonArticles();
        }
      },
    );
  }

  @override
  void dispose() {
    _subscriptionStreamSubscription?.cancel();
    _unsubscriptionStreamSubscription?.cancel();
    _eventController.close();
    super.dispose();
  }
}
