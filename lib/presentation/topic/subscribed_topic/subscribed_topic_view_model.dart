import 'dart:async';
import 'package:could_be/core/events/topic_subscription_events.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_state.dart';
import 'package:flutter/cupertino.dart';
import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../../../domain/useCases/fetch_topics_use_case.dart';

class SubscribedTopicViewModel with ChangeNotifier {
  final FetchTopicsUseCase _fetchTopicsUseCase;
  final FetchIssuesUseCase _fetchIssuesUseCase;

  // 상태
  SubscribedTopicState _state = SubscribedTopicState();
  SubscribedTopicState get state => _state;

  // Stream subscriptions
  StreamSubscription<String>? _subscriptionStreamSubscription;
  StreamSubscription<String>? _unsubscriptionStreamSubscription;

  SubscribedTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required FetchIssuesUseCase fetchIssuesUseCase,
  }) : _fetchTopicsUseCase = fetchTopicsUseCase,
       _fetchIssuesUseCase = fetchIssuesUseCase {
    _fetchSubscribedTopics();
    _fetchSubscribedTopicIssuesWhole();
    _setupSubscriptionListeners();
  }

  void setSelectedTopicId(String topicId) {
    if (topicId == _state.selectedTopicId) {
      _state = state.copyWith(selectedTopicId: null);
      _fetchSubscribedTopicIssuesWhole();
    } else {
      _state = state.copyWith(selectedTopicId: topicId);
      _fetchSpecificTopicIssues(topicId);
    }
  }

  void _fetchSubscribedTopics() async {
    _state = state.copyWith(
      isTopicLoading: true,
      selectedTopicId: state.selectedTopicId,
    );
    notifyListeners();

    final result = await _fetchTopicsUseCase.fetchSubscribedTopics();
    _state = state.copyWith(
      topics: result,
      isTopicLoading: false,
      selectedTopicId: state.selectedTopicId,
    );
    notifyListeners();
  }

  void _fetchSubscribedTopicIssuesWhole() async {
    _state = state.copyWith(
      isIssuesLoading: true,
      selectedTopicId: state.selectedTopicId,
    );
    notifyListeners();

    final result = await _fetchIssuesUseCase.fetchSubscribedTopicIssuesWhole();
    _state = state.copyWith(
      issues: result,
      isIssuesLoading: false,
      selectedTopicId: state.selectedTopicId,
    );
    notifyListeners();
  }

  void _fetchSpecificTopicIssues(String topicId) async {
    _state = state.copyWith(isIssuesLoading: true, selectedTopicId: topicId);
    notifyListeners();

    final result = await _fetchIssuesUseCase.fetchIssuesByTopicId(topicId);
    _state = state.copyWith(
      issues: result,
      isIssuesLoading: false,
      selectedTopicId: topicId
    );
    notifyListeners();
  }

  void _setupSubscriptionListeners() {
    _subscriptionStreamSubscription = TopicSubscriptionEvents
        .subscriptionStream
        .listen((topicId) {
          _fetchSubscribedTopics();
          _fetchSubscribedTopicIssuesWhole();
        });

    _unsubscriptionStreamSubscription = TopicSubscriptionEvents
        .unsubscriptionStream
        .listen((topicId) {
          _fetchSubscribedTopics();
          _fetchSubscribedTopicIssuesWhole();
        });
  }

  @override
  void dispose() {
    _subscriptionStreamSubscription?.cancel();
    _unsubscriptionStreamSubscription?.cancel();
    super.dispose();
  }
}
