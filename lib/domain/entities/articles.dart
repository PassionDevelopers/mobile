

import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/articles_group_by_bias.dart';
import 'package:could_be/domain/entities/source.dart';

import '../../core/components/bias/bias_enum.dart';
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

  ArticlesGroupByBias toGroupByBias() {
    final Map<Bias, List<Article>> articlesByBias = {
      Bias.left: [],
      Bias.center: [],
      Bias.right: [],
    };

    for (final article in articles) {
      Bias bias = getBiasFromString(article.source.perspective);
      if (bias == Bias.leftCenter) bias = Bias.left;
      if (bias == Bias.rightCenter) bias = Bias.right;
      articlesByBias[bias]!.add(article);
    }
    return ArticlesGroupByBias(articlesByBias: articlesByBias,
      allArticles: articles,
    );
  }
}