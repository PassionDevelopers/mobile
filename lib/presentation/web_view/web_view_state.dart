import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/article/articles.dart';
import '../../domain/entities/article/articles_group_by_source.dart';

class WebViewState{
  final bool isLoading;
  final ArticlesGroupBySource? articlesGroupBySource;
  final WebViewController? controller;
  final String currentSourceId;
  final String currentArticleId;


  const WebViewState({
    this.isLoading = false,
    this.controller,
    this.articlesGroupBySource,
    required this.currentSourceId,
    required this.currentArticleId,
  });

  WebViewState copyWith({
    bool? isLoading,
    ArticlesGroupBySource? articlesGroupBySource,
    WebViewController? controller,
    String? currentSourceId,
    String? currentArticleId,
  }) {
    return WebViewState(
      isLoading: isLoading ?? this.isLoading,
      articlesGroupBySource: articlesGroupBySource ?? this.articlesGroupBySource,
      controller: controller ?? this.controller,
      currentSourceId: currentSourceId ?? this.currentSourceId,
      currentArticleId: currentArticleId ?? this.currentArticleId,
    );
  }
}