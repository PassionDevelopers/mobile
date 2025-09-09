import 'package:could_be/domain/entities/article/article.dart';
import 'package:could_be/domain/entities/source/source.dart';

class ArticlesGroupBySource {
  final List<Source> sources;
  final Map<String, List<Article>> articlesWithSources;

  ArticlesGroupBySource({
    required this.sources,
    required this.articlesWithSources,
  });
}