import 'package:could_be/domain/entities/topic.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view.dart';

import '../../../domain/entities/topics.dart';

enum Categories {
  politics,
  economy,
  society,
  culture,
  international,
  technology;

  String get name {
    switch (this) {
      case Categories.politics:
        return '정치';
      case Categories.economy:
        return '경제';
      case Categories.society:
        return '사회';
      case Categories.culture:
        return '문화';
      case Categories.international:
        return '세계';
      case Categories.technology:
        return '기술';
    }
  }

  String get id {
    switch (this) {
      case Categories.politics:
        return 'politics';
      case Categories.economy:
        return 'economy';
      case Categories.society:
        return 'society';
      case Categories.culture:
        return 'culture';
      case Categories.international:
        return 'international';
      case Categories.technology:
        return 'technology';
    }
  }
}

class WholeTopicState{
  bool isLoading;
  Categories categoryNow;
  Map<Categories, Topics>? allTopics;
  Topics? get topics => allTopics?[categoryNow];
  Map<Categories, List<Topic>>? searchedTopics;
  bool isShowSearchedTopics;
  String? query;

  WholeTopicState({
    this.isLoading = false,
    this.categoryNow = Categories.politics,
    this.allTopics,
    this.searchedTopics,
    this.isShowSearchedTopics = false,
    this.query,
  });

  WholeTopicState copyWith({
    bool? isLoading,
    Categories? categoryNow,
    Map<Categories, Topics>? allTopics,
    Map<Categories, List<Topic>>? searchedTopics,
    bool? isShowSearchedTopics,
    String? query,
  }) {
    return WholeTopicState(
      isLoading: isLoading ?? this.isLoading,
      categoryNow: categoryNow ?? this.categoryNow,
      allTopics: allTopics ?? this.allTopics,
      searchedTopics: searchedTopics ?? this.searchedTopics,
      isShowSearchedTopics: isShowSearchedTopics ?? this.isShowSearchedTopics,
      query: query ?? this.query,
    );
  }
}