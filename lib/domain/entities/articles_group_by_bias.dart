import 'package:could_be/domain/entities/source.dart';

import '../../core/components/bias/bias_enum.dart';
import 'article.dart';

class ArticlesGroupByBiasAndSource {
  final Map<Bias, List<OneSourceArticles>> oneSourceArticlesByBias;
  final List<Article> allArticles;

  ArticlesGroupByBiasAndSource({
    required this.oneSourceArticlesByBias,
    required this.allArticles,
  });
}

class OneSourceArticles {
  final Source source;
  final List<Article> articles;
  OneSourceArticles({
    required this.source,
    required this.articles,
  });
}

