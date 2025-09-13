import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';

class SearchState{
  String? query;
  Map<Categories, List<Topic>>? searchedTopics;
  bool isLoading;

  SearchState({
    this.query,
    this.searchedTopics,
    this.isLoading = false,
  });

  SearchState copyWith({
    String? query,
    Map<Categories, List<Topic>>? searchedTopics,
    bool? isLoading,
  }){
    return SearchState(
      query: query ?? this.query,
      searchedTopics: searchedTopics ?? this.searchedTopics,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}