import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/medium.dart';
import 'articles_dto.dart';
import 'issues_dto.dart';
part 'medium_dto.g.dart';

@JsonSerializable()
class MediumDTO {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String perspective;
  final String url;
  final String logoUrl;
  final IssuesDTO recentIssues;
  final ArticlesDTO recentArticles;
  final bool isSubscribed;
  final String? userEvaluatedPerspective;

  MediumDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.perspective,
    required this.url,
    required this.logoUrl,
    required this.recentIssues,
    required this.recentArticles,
    required this.isSubscribed,
    required this.userEvaluatedPerspective,
  });

  factory MediumDTO.fromJson(Map<String, dynamic> json) =>
      _$MediumDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MediumDTOToJson(this);
}

extension MediumDtx on MediumDTO {
  // Converts the DTO to a domain entity
  Medium toDomain() {
    return Medium(
      id: id,
      name: name,
      description: description,
      perspective: perspective,
      url: url,
      logoUrl: logoUrl,
      recentIssues: recentIssues.toDomain(),
      recentArticles: recentArticles.toDomain(),
      isSubscribed: isSubscribed,
      userEvaluatedPerspective: userEvaluatedPerspective,
    );
  }
}
