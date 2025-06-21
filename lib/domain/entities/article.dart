

import 'article_source.dart';

class Article{
  final String id;
  final String title;
  final String preview;
  final String url;
  final String? reporter;
  final String publishedAt;
  final String issueId;
  final String category;
  final String? imageUrl;
  final ArticleSource source;

  Article({
    required this.id,
    required this.title,
    required this.preview,
    required this.url,
    this.reporter,
    required this.publishedAt,
    required this.issueId,
    required this.category,
    this.imageUrl,
    required this.source,
  });
}