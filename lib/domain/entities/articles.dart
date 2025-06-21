

import 'article.dart';

class Articles{
  final List<Article> articles;
  final bool hasMore;
  final String lastArticleId;

  Articles({
    required this.articles,
    required this.hasMore,
    required this.lastArticleId,
  });
}