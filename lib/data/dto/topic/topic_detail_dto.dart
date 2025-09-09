import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/topic/topic_detail.dart';
import '../issue/issues_dto.dart';

part 'topic_detail_dto.g.dart';

@JsonSerializable()
class TopicDetailDto {
  final String id;
  final String name;
  final String category;
  final String description;
  @JsonKey(name: 'recent_issues')
  final IssuesDTO recentIssues;
  @JsonKey(name: 'is_subscribed')
  final bool isSubscribed;
  @JsonKey(name: 'total_issues_count')
  final int totalIssuesCount;
  @JsonKey(name: 'subscribers_count')
  final int subscribersCount;
  @JsonKey(name: 'notification_enabled')
  final bool notificationEnabled;

  TopicDetailDto({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.recentIssues,
    required this.isSubscribed,
    required this.totalIssuesCount,
    required this.subscribersCount,
    required this.notificationEnabled,
  });

  factory TopicDetailDto.fromJson(Map<String, dynamic> json) => _$TopicDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TopicDetailDtoToJson(this);

  TopicDetail toDomain() {
    return TopicDetail(
      id: id,
      name: name,
      category: category,
      description: description,
      recentIssues: recentIssues.toDomain(),
      isSubscribed: isSubscribed,
      totalIssuesCount: totalIssuesCount,
      subscribersCount: subscribersCount,
      notificationEnabled: notificationEnabled,
    );
  }
}