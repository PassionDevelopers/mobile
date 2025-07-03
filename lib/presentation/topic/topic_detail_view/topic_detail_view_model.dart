import 'package:could_be/domain/useCases/fetch_topic_detail_use_case.dart';
import 'package:could_be/presentation/topic/topic_detail_view/topic_detail_state.dart';
import 'package:flutter/cupertino.dart';

class TopicDetailViewModel with ChangeNotifier {
  final FetchTopicDetailUseCase _fetchTopicDetailUseCase;

  TopicDetailViewModel({
    required String topicId,
    required FetchTopicDetailUseCase fetchTopicDetailUseCase,
  }) : _fetchTopicDetailUseCase = fetchTopicDetailUseCase {
    _fetchTopicDetail(topicId);
  }

  TopicDetailState _state = TopicDetailState();

  TopicDetailState get state => _state;

  Future<void> _fetchTopicDetail(String topicId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchTopicDetailUseCase.fetchTopicDetailById(topicId);

    _state = state.copyWith(
      topicDetail: result,
      isLoading: false,
    );

    notifyListeners();
  }
}