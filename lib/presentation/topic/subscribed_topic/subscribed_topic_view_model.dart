import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../../../domain/useCases/fetch_topics_use_case.dart';

class SubscribedTopicViewModel with ChangeNotifier{
  final FetchTopicsUseCase _fetchTopicsUseCase;
  final FetchIssuesUseCase _fetchIssuesUseCase;
  // 상태
  SubscribedTopicState _state = SubscribedTopicState();
  SubscribedTopicState get state => _state;

  SubscribedTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required FetchIssuesUseCase fetchIssuesUseCase,
  }): _fetchTopicsUseCase = fetchTopicsUseCase,
      _fetchIssuesUseCase = fetchIssuesUseCase {
    _fetchSubscribedTopics();
    _fetchSubscribedIssues();
  }

  void _fetchSubscribedTopics() async {
    _state = state.copyWith(isTopicLoading: true);
    notifyListeners();

    final result = await _fetchTopicsUseCase.fetchSubscribedTopics();
    _state = state.copyWith(
      topics: result,
      isTopicLoading: false,
    );
    notifyListeners();
  }

  void _fetchSubscribedIssues() async {
    _state = state.copyWith(isIssuesLoading: true);
    notifyListeners();

    final result = await _fetchIssuesUseCase.fetchSubscribedIssues();
    _state = state.copyWith(
      issues: result,
      isIssuesLoading: false,
    );
    notifyListeners();
  }
}