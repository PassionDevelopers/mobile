

import 'package:could_be/domain/entities/source.dart';

import 'article.dart';
import 'articles_group_by_source.dart';

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

extension ArticlesExtension on Articles {
  ArticlesGroupBySource toGroupBySource(){
    final Map<String, List<Article>> articlesWithSources = {};
    final List<Source> sources = [];

    for (final article in articles) {
      if (!articlesWithSources.containsKey(article.source.id)) {
        articlesWithSources[article.source.id] = [];
        sources.add(article.source);
      }
      articlesWithSources[article.source.id]!.add(article);
    }

    return ArticlesGroupBySource(
      sources: sources,
      articlesWithSources: articlesWithSources,
    );
  }
}