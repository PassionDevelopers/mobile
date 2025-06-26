import '../../../domain/entities/topics.dart';

class WholeTopicState{
  bool isLoading;
  Topics? topics;

  WholeTopicState({
    this.isLoading = false,
    this.topics,
  });

  WholeTopicState copyWith({
    bool? isLoading,
    Topics? topics,
  }) {
    return WholeTopicState(
      isLoading: isLoading ?? this.isLoading,
      topics: topics ?? this.topics,
    );
  }
}