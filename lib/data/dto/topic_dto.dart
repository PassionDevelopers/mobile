import 'package:could_be/domain/entities/topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_dto.g.dart';

@JsonSerializable()
class TopicDto {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String category;
  final int? issuesCount;
  final bool isSubscribed;

  TopicDto(
      {required this.id,
      required this.name,
      required this.category,
      required this.issuesCount,
      required this.isSubscribed}
  );

  factory TopicDto.fromJson(Map<String, dynamic> json) =>
      _$TopicDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TopicDtoToJson(this);
}

extension TopicDtoExtension on TopicDto {
  Topic toDomain() {
    return Topic(
      id: id,
      name: name,
      category: category,
      issuesCount: issuesCount,
      isSubscribed: isSubscribed,
    );
  }
}
