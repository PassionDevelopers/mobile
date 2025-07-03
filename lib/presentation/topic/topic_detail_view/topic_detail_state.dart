import '../../../domain/entities/topic_detail.dart';

class TopicDetailState {
  final bool isLoading;
  final TopicDetail? topicDetail;

  TopicDetailState({
    this.isLoading = false,
    this.topicDetail,
  });

  TopicDetailState copyWith({
    bool? isLoading,
    TopicDetail? topicDetail,
  }) {
    return TopicDetailState(
      isLoading: isLoading ?? this.isLoading,
      topicDetail: topicDetail ?? this.topicDetail,
    );
  }
}