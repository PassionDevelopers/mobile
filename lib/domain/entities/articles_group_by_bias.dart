import '../../core/components/bias/bias_enum.dart';
import 'article.dart';

class ArticlesGroupByBias {
  final Map<Bias, List<Article>> articlesByBias;
  final List<Article> allArticles;

  ArticlesGroupByBias({
    required this.articlesByBias,
    required this.allArticles,
  });
}