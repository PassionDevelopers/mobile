import 'package:could_be/domain/models/source_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel{
  @JsonKey(name: '_id')
  String id;
  String preview;
  String title;
  String summary;
  String content;
  String url;
  String? reporter;
  SourceModel source;
  DateTime publishedAt;
  String issueId;
  String category;
  String? imageUrl;

  ArticleModel({
    required this.id,
    required this.preview,
    required this.title,
    required this.summary,
    required this.content,
    required this.url,
    this.reporter,
    required this.source,
    required this.publishedAt,
    required this.issueId,
    required this.category,
    this.imageUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}