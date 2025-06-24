
import 'package:could_be/domain/entities/sources.dart';

import '../../../domain/entities/articles.dart';

class SubscribedMediaState {
  final Sources? sources;
  final Articles? articles;
  final bool isSourcesLoading;
  final bool isArticlesLoading;
  final String? selectedSourceId;

  SubscribedMediaState({
    this.sources,
    this.articles,
    this.isSourcesLoading = false,
    this.isArticlesLoading = false,
    this.selectedSourceId,
  });

  SubscribedMediaState copyWith({
    Sources? sources,
    Articles? articles,
    bool? isSourcesLoading,
    bool? isArticlesLoading,
    String? selectedSourceId,
  }) {
    return SubscribedMediaState(
      sources: sources ?? this.sources,
      articles: articles ?? this.articles,
      isSourcesLoading: isSourcesLoading ?? this.isSourcesLoading,
      isArticlesLoading: isArticlesLoading ?? this.isArticlesLoading,
      selectedSourceId: selectedSourceId ?? this.selectedSourceId,
    );
  }
}