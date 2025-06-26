import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/useCases/fetch_topics_use_case.dart';

class WholeTopicViewModel extends ChangeNotifier{
  final FetchTopicsUseCase _fetchTopicsUseCase;

  WholeTopicViewModel({
    required FetchTopicsUseCase fetchTopicsUseCase,
    required String category,
  }) : _fetchTopicsUseCase = fetchTopicsUseCase {
    _fetchSpecificCategoryTopics(category);
  }

  // 상태
  WholeTopicState _state = WholeTopicState();
  WholeTopicState get state => _state;

  Future<void> _fetchSpecificCategoryTopics(String category) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchTopicsUseCase.fetchSepecificCategoryTopics(category);
    _state = state.copyWith(
      topics: result,
      isLoading: false,
    );

    notifyListeners();
  }
}