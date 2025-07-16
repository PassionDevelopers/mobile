import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/events/topic_subscription_events.dart';
import 'package:could_be/domain/entities/topic.dart';
import 'package:could_be/domain/useCases/search_topics_use_case.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/useCases/fetch_topics_use_case.dart';
import '../../../domain/useCases/manage_topic_subscription_use_case.dart';

class WholeTopicViewModel extends ChangeNotifier {
  final FetchTopicsUseCase _fetchTopicsUseCase;
  final SearchTopicsUseCase _searchTopicsUseCase;
  final ManageTopicSubscriptionUseCase _manageTopicSubscriptionUseCase;

  WholeTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required SearchTopicsUseCase searchTopicsUseCase,
    required ManageTopicSubscriptionUseCase manageTopicSubscriptionUseCase,
    required String category,
  }) : _fetchTopicsUseCase = fetchTopicsUseCase,
        _searchTopicsUseCase = searchTopicsUseCase,
       _manageTopicSubscriptionUseCase = manageTopicSubscriptionUseCase {
    for(final category in Categories.values) {
      _fetchSpecificCategoryTopics(category);
    }
  }

  // 상태
  WholeTopicState _state = WholeTopicState();

  WholeTopicState get state => _state;

  void hideSearchedTopics() {
    _state = state.copyWith(
      isShowSearchedTopics: false,
    );
    notifyListeners();
  }

  void setCategoryNow(Categories category) {
    _state = state.copyWith(categoryNow: category);
    notifyListeners();
  }

  Future<void> searchTopics(String query) async {
    _state = state.copyWith(
        isShowSearchedTopics: true,
        query: query,
        isLoading: true);
    notifyListeners();

    final result = await _searchTopicsUseCase.searchTopics(query);
    final Map<Categories, List<Topic>> searchedTopics = {};
    for (final category in Categories.values) {
      searchedTopics[category] = result.topics.where(
            (topic) => topic.category == category.id,
      ).toList();
    }

    _state = state.copyWith(searchedTopics: searchedTopics,
        isShowSearchedTopics: true,
        query: query,
        isLoading: false);

    notifyListeners();
  }

  Future<void> _fetchSpecificCategoryTopics(Categories category) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchTopicsUseCase.fetchSepecificCategoryTopics(
      category.id,
    );
    final allTopics = state.allTopics ?? {};
    if(allTopics.containsKey(category)){
      allTopics[category] = allTopics[category]!.copyWith(
        topics: allTopics[category]!.topics + result.topics,
        hasMore: result.hasMore,
        lastTopicId: result.lastTopicId,
      );
    } else {
      allTopics[category] = result;
    }
    _state = state.copyWith(allTopics: allTopics, isLoading: false);
    notifyListeners();
  }

  Future<void> manageTopicSubscription(String topicId) async {
    final topic = state.topics!.topics.firstWhere(
      (topic) => topic.id == topicId,
    );

    if (topic.isSubscribed) {
      await unsubscribeTopicByTopicId(topicId);
    } else {
      await subscribeTopicByTopicId(topicId);
    }
    showMyToast(
      msg: topic.isSubscribed ? "관심 토픽에서 해제하였습니다." : "관심 토픽으로 등록하였습니다.",
    );
    notifyListeners();
  }

  Future<void> subscribeTopicByTopicId(String topicId) async {
    await _manageTopicSubscriptionUseCase.subscribeTopicByTopicId(topicId);
    updateTopicSubscription(topicId, true);
    TopicSubscriptionEvents.notifyTopicSubscribed(topicId);
  }

  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    await _manageTopicSubscriptionUseCase.unsubscribeTopicByTopicId(topicId);
    updateTopicSubscription(topicId, false);
    TopicSubscriptionEvents.notifyTopicUnsubscribed(topicId);
  }

  Future<void> updateTopicSubscription(String topicId, bool isSubscribed) async {
    final allTopics = state.allTopics ?? {};
    allTopics[state.categoryNow] = allTopics[state.categoryNow]!.copyWith(
      topics: allTopics[state.categoryNow]!.topics
          .map(
            (topic) => topic.id == topicId
            ? topic.copyWith(isSubscribed: isSubscribed)
            : topic,
      )
          .toList(),
    );
    _state = state.copyWith(
      allTopics: allTopics,
    );
  }
}
