import 'dart:async';
import 'package:could_be/core/events/topic_subscription_events.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_state.dart';
import 'package:flutter/cupertino.dart';
import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../../../domain/useCases/fetch_topics_use_case.dart';

class SubscribedTopicViewModel with ChangeNotifier {
  final FetchTopicsUseCase _fetchTopicsUseCase;

  // 상태
  SubscribedTopicState _state = SubscribedTopicState();
  SubscribedTopicState get state => _state;

  // Stream subscriptions
  StreamSubscription<String>? _subscriptionStreamSubscription;
  StreamSubscription<String>? _unsubscriptionStreamSubscription;

  SubscribedTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required FetchIssuesUseCase fetchIssuesUseCase,
  }) : _fetchTopicsUseCase = fetchTopicsUseCase{
    _fetchSubscribedTopics();
    _setupSubscriptionListeners();
  }

  void setSelectedTopicId(String topicId) {
    if (topicId == _state.selectedTopicId) {
      _state = state.copyWith(selectedTopicId: null);
    } else {
      _state = state.copyWith(selectedTopicId: topicId);
    }
    notifyListeners();
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

  void _setupSubscriptionListeners() {
    _subscriptionStreamSubscription = TopicSubscriptionEvents
        .subscriptionStream
        .listen((topicId) {
          _fetchSubscribedTopics();
        });

    _unsubscriptionStreamSubscription = TopicSubscriptionEvents
        .unsubscriptionStream
        .listen((topicId) {
          _fetchSubscribedTopics();
        });
  }

  @override
  void dispose() {
    _subscriptionStreamSubscription?.cancel();
    _unsubscriptionStreamSubscription?.cancel();
    super.dispose();
  }
}
