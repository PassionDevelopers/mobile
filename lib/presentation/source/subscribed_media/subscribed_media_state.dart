
import 'package:could_be/domain/entities/source/sources.dart';

import '../../../domain/entities/article/articles.dart';

class SubscribedMediaState {
  final Sources? sources;
  final Articles? articles;
  final bool isSourcesLoading;
  final bool isArticlesLoading;
  final String? selectedSourceId;
  final bool isLoadingMore;

  SubscribedMediaState({
    this.sources,
    this.articles,
    this.isSourcesLoading = false,
    this.isArticlesLoading = false,
    this.isLoadingMore = false,
    this.selectedSourceId,
  });

  SubscribedMediaState copyWith({
    Sources? sources,
    Articles? articles,
    bool? isSourcesLoading,
    bool? isArticlesLoading,
    required String? selectedSourceId,
    bool? isLoadingMore,
  }) {
    return SubscribedMediaState(
      sources: sources ?? this.sources,
      articles: articles ?? this.articles,
      isSourcesLoading: isSourcesLoading ?? this.isSourcesLoading,
      isArticlesLoading: isArticlesLoading ?? this.isArticlesLoading,
      selectedSourceId: selectedSourceId,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}