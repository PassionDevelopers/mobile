

import 'package:could_be/domain/useCases/fetch_articles_use_case.dart';
import 'package:could_be/domain/useCases/fetch_sources_use_case.dart';
import 'package:could_be/presentation/media/main/subscribed_media_state.dart';
import 'package:flutter/cupertino.dart';

class SubscribedMediaViewModel with ChangeNotifier{
  final FetchSourcesUseCase _fetchSourcesUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;

  SubscribedMediaState _state = SubscribedMediaState();
  SubscribedMediaState get state => _state;

  SubscribedMediaViewModel({
    required FetchSourcesUseCase fetchSourcesUseCase,
    required FetchArticlesUseCase fetchArticlesUseCase,
  }) : _fetchSourcesUseCase = fetchSourcesUseCase,
       _fetchArticlesUseCase = fetchArticlesUseCase {
    _fetchSubscribedSources();
    _fetchCommonArticles();
  }

  void setSelectedSourceId(String? sourceId) {
    _state = state.copyWith(selectedSourceId: sourceId);
    print('selectedSourceId: ${_state.selectedSourceId}');

    if (sourceId == null) {
      _fetchCommonArticles();
    } else {
      _fetchSpecificSourceArticles(sourceId);
    }

  }

  void _fetchSubscribedSources() async {
    _state = state.copyWith(isSourcesLoading: true);
    notifyListeners();

    final result = await _fetchSourcesUseCase.fetchSubscribedSources();
    _state = state.copyWith(
      sources: result,
      isSourcesLoading: false,
    );

    notifyListeners();
  }

  void _fetchSpecificSourceArticles(String sourceId) async{
    _state = state.copyWith(isArticlesLoading: true);
    notifyListeners();

    final result = await _fetchArticlesUseCase.fetchArticlesBySourceId(sourceId);
    _state = state.copyWith(
      articles: result,
      isArticlesLoading: false,
    );

    print('Fetched articles for sourceId: $sourceId');

    notifyListeners();
  }

  void _fetchCommonArticles() async {
    _state = state.copyWith(isArticlesLoading: true);
    notifyListeners();

    final result = await _fetchArticlesUseCase.fetchArticlesSubscribed();
    _state = state.copyWith(
      articles: result,
      isArticlesLoading: false,
    );

    notifyListeners();
  }
}