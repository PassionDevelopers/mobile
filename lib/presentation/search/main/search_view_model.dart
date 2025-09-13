import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:could_be/presentation/search/main/search_state.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/useCases/topic/search_topics_use_case.dart' show SearchTopicsUseCase;

class SearchViewModel with ChangeNotifier{

  final SearchTopicsUseCase _searchTopicsUseCase;

  SearchViewModel({
    required SearchTopicsUseCase searchTopicsUseCase,
  }) : _searchTopicsUseCase = searchTopicsUseCase;

  SearchState _state = SearchState();

  SearchState get state => _state;

  Future<void> searchTopics(String query) async {
    _state = state.copyWith(
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
        query: query,
        isLoading: false);

    notifyListeners();
  }
}