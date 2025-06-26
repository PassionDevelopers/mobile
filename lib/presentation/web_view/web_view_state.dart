import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/articles.dart';
import '../../domain/entities/articles_group_by_source.dart';

class WebViewState{
  final bool isLoading;
  final ArticlesGroupBySource? articlesGroupBySource;
  final WebViewController? controller;
  final int currentSourceIndex;
  final int currentArticleIndex;


  const WebViewState({
    this.isLoading = false,
    this.controller,
    this.articlesGroupBySource,
    this.currentSourceIndex = 0,
    this.currentArticleIndex = 0,
  });

  WebViewState copyWith({
    bool? isLoading,
    ArticlesGroupBySource? articlesGroupBySource,
    WebViewController? controller,
    int? currentSourceIndex,
    int? currentArticleIndex,
  }) {
    return WebViewState(
      isLoading: isLoading ?? this.isLoading,
      articlesGroupBySource: articlesGroupBySource ?? this.articlesGroupBySource,
      controller: controller ?? this.controller,
      currentSourceIndex: currentSourceIndex ?? this.currentSourceIndex,
      currentArticleIndex: currentArticleIndex ?? this.currentArticleIndex,
    );
  }
}