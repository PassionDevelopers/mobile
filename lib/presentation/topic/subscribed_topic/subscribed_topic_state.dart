import 'package:could_be/domain/entities/topics.dart';

import '../../../domain/entities/issues.dart';

class SubscribedTopicState {
  final Topics? topics;
  final bool isTopicLoading;
  final Issues? issues;
  final bool isIssuesLoading;

  SubscribedTopicState({
    this.topics,
    this.isTopicLoading = false,
    this.issues,
    this.isIssuesLoading = false,
  });

  SubscribedTopicState copyWith({
    Topics? topics,
    bool? isTopicLoading,
    Issues? issues,
    bool? isIssuesLoading,
  }) {
    return SubscribedTopicState(
      topics: topics ?? this.topics,
      isTopicLoading: isTopicLoading ?? this.isTopicLoading,
      issues: issues ?? this.issues,
      isIssuesLoading: isIssuesLoading ?? this.isIssuesLoading,
    );
  }
}