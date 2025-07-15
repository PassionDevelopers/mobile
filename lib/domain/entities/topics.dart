import 'package:could_be/domain/entities/topic.dart';

class Topics{
  final List<Topic> topics;
  final bool hasMore;
  final String? lastTopicId;

  Topics({
    required this.topics,
    required this.hasMore,
    required this.lastTopicId,
  });

  Topics copyWith({
    List<Topic>? topics,
    bool? hasMore,
    String? lastTopicId,
  }) {
    return Topics(
      topics: topics ?? this.topics,
      hasMore: hasMore ?? this.hasMore,
      lastTopicId: lastTopicId ?? this.lastTopicId,
    );
  }
}
