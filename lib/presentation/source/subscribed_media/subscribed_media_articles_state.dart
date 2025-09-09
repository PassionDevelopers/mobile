

import 'package:could_be/domain/entities/article/articles.dart';

class SubscribedMediaArticlesState {
  final Articles? articles;
  final bool isLoading;

  SubscribedMediaArticlesState({
    this.articles,
    this.isLoading = false,
  });

  SubscribedMediaArticlesState copyWith({
    Articles? articles,
    bool? isLoading,
  }) {
    return SubscribedMediaArticlesState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}