import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/domain/entities/topics.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/useCases/fetch_topics_use_case.dart';
import '../../../domain/useCases/manage_topic_subscription_use_case.dart';
import '../../../ui/color.dart';

class WholeTopicViewModel extends ChangeNotifier {
  final FetchTopicsUseCase _fetchTopicsUseCase;
  final ManageTopicSubscriptionUseCase _manageTopicSubscriptionUseCase;

  WholeTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required ManageTopicSubscriptionUseCase manageTopicSubscriptionUseCase,
    required String category,
  }) : _fetchTopicsUseCase = fetchTopicsUseCase,
       _manageTopicSubscriptionUseCase = manageTopicSubscriptionUseCase {
    _fetchSpecificCategoryTopics(category);
  }

  // 상태
  WholeTopicState _state = WholeTopicState();

  WholeTopicState get state => _state;

  Future<void> _fetchSpecificCategoryTopics(String category) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchTopicsUseCase.fetchSepecificCategoryTopics(
      category,
    );
    _state = state.copyWith(topics: result, isLoading: false);

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
    _state = state.copyWith(
      topics: state.topics!.copyWith(
        topics:
            state.topics!.topics
                .map(
                  (topic) =>
                      topic.id == topicId
                          ? topic.copyWith(isSubscribed: true)
                          : topic,
                )
                .toList(),
      ),
    );
  }

  Future<void> unsubscribeTopicByTopicId(String topicId) async {
    await _manageTopicSubscriptionUseCase.unsubscribeTopicByTopicId(topicId);
    _state = state.copyWith(
      topics: state.topics!.copyWith(
        topics:
            state.topics!.topics
                .map(
                  (topic) =>
                      topic.id == topicId
                          ? topic.copyWith(isSubscribed: false)
                          : topic,
                )
                .toList(),
      ),
    );
  }
}
