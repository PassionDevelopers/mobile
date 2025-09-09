import 'package:could_be/domain/entities/topic/topics.dart';

import '../../../domain/entities/issue/issues.dart';

class SubscribedTopicState {
  final Topics? topics;
  final bool isTopicLoading;
  final String? selectedTopicId;

  SubscribedTopicState({
    this.topics,
    this.isTopicLoading = false,
    this.selectedTopicId,
  });

  SubscribedTopicState copyWith({
    Topics? topics,
    bool? isTopicLoading,
    Issues? issues,
    bool? isIssuesLoading,
    required String? selectedTopicId,
  }) {
    return SubscribedTopicState(
      topics: topics ?? this.topics,
      isTopicLoading: isTopicLoading ?? this.isTopicLoading,
      selectedTopicId: selectedTopicId
    );
  }
}