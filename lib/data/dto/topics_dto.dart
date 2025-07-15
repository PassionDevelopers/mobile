import 'package:could_be/data/dto/topic_dto.dart';
import 'package:could_be/domain/entities/topics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'topics_dto.g.dart';

@JsonSerializable()
class TopicsDto {
  final List<TopicDto> topics;
  final bool hasMore;
  final String? lastTopicId;

  TopicsDto({
    required this.topics,
    required this.hasMore,
    this.lastTopicId,
  });

  factory TopicsDto.fromJson(Map<String, dynamic> json) =>
      _$TopicsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TopicsDtoToJson(this);
}

extension TopicsDtoExtension on TopicsDto {
  Topics toDomain() {
    return Topics(
      topics: topics.map((topic) => topic.toDomain()).toList(),
      hasMore: hasMore,
      lastTopicId: lastTopicId,
    );
  }
}

