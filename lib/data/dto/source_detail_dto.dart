import 'package:could_be/data/dto/articles_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/source_detail.dart';

part 'source_detail_dto.g.dart';

@JsonSerializable()
class SourceDetailDto {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String perspective;
  final String url;
  final String logoUrl;
  final ArticlesDTO recentArticles;
  final bool isSubscribed;
  final String? userEvaluatedPerspective;
  final String aiEvaluatedPerspective;
  final String? expertEvaluatedPerspective;
  final String? publicEvaluatedPerspective;
  final int followersCount;
  final bool notificationEnabled;

  SourceDetailDto(
    this.id,
    this.name,
    this.description,
    this.perspective,
    this.url,
    this.logoUrl,
    this.recentArticles,
    this.isSubscribed,
    this.userEvaluatedPerspective,
    this.aiEvaluatedPerspective,
    this.expertEvaluatedPerspective,
    this.publicEvaluatedPerspective,
    this.followersCount,
    this.notificationEnabled,
  );

  factory SourceDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SourceDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SourceDetailDtoToJson(this);
}

extension SourceDetailDtoExtension on SourceDetailDto {
  /// Converts the DTO to a domain entity.
  SourceDetail toDomain() {
    return SourceDetail(
      id: id,
      name: name,
      description: description,
      perspective: perspective,
      url: url,
      logoUrl: logoUrl,
      recentArticles: recentArticles.toDomain(),
      isSubscribed: isSubscribed,
      userEvaluatedPerspective: userEvaluatedPerspective,
      aiEvaluatedPerspective: aiEvaluatedPerspective,
      expertEvaluatedPerspective: expertEvaluatedPerspective,
      publicEvaluatedPerspective: publicEvaluatedPerspective,
      totalIssuesCount: followersCount,
      notificationEnabled: notificationEnabled,
    );
  }
}

