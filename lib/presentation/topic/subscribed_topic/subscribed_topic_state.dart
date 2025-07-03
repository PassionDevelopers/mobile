import 'package:could_be/domain/entities/topics.dart';

import '../../../domain/entities/issues.dart';

class SubscribedTopicState {
  final Topics? topics;
  final bool isTopicLoading;
  final Issues? issues;
  final bool isIssuesLoading;
  final String? selectedTopicId;

  SubscribedTopicState({
    this.topics,
    this.isTopicLoading = false,
    this.issues,
    this.isIssuesLoading = false,
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
      issues: issues ?? this.issues,
      isIssuesLoading: isIssuesLoading ?? this.isIssuesLoading,
      selectedTopicId: selectedTopicId
    );
  }
}