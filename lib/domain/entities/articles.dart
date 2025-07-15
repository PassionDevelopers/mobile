

import 'package:could_be/domain/entities/articles_group_by_bias.dart';
import 'package:could_be/domain/entities/source.dart';

import '../../core/components/bias/bias_enum.dart';
import 'article.dart';
import 'articles_group_by_source.dart';

class Articles{
  final List<Article> articles;
  final bool hasMore;
  final String? lastArticleId;

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

  ArticlesGroupByBiasAndSource toGroupByBiasAndSource() {
    Map<String, List<Article>> articlesGroupBySources = {};
    for( final article in articles) {
      if(!articlesGroupBySources.containsKey(article.source.id)) {
        articlesGroupBySources[article.source.id] = [article];
      }else{
        articlesGroupBySources[article.source.id]!.add(article);
      }
    }

    List<OneSourceArticles> oneSourceArticles = [];
    for( final articlesGroupBySource in articlesGroupBySources.values) {
      final source = articlesGroupBySource.first.source;
      oneSourceArticles.add(OneSourceArticles(
        source: source,
        articles: articlesGroupBySource,
      ));
    }

    final Map<Bias, List<OneSourceArticles>> oneSourceArticlesByBias = {};
    for (final oneSourceArticle in oneSourceArticles) {
      Bias bias = oneSourceArticle.source.bias;
      if(bias == Bias.leftCenter) {
        bias = Bias.left;
      } else if(bias == Bias.rightCenter) {
        bias = Bias.right;
      }
      if(!oneSourceArticlesByBias.containsKey(bias)){
        oneSourceArticlesByBias[bias] = [oneSourceArticle];
      }else{
        oneSourceArticlesByBias[bias]!.add(oneSourceArticle);
      }
    }
    return ArticlesGroupByBiasAndSource(
      oneSourceArticlesByBias: oneSourceArticlesByBias,
      allArticles: articles,
    );
  }
}