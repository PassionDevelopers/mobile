import 'dart:developer';

import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:could_be/domain/entities/issue/issue_query_params.dart';
import 'package:could_be/domain/entities/issue/issues.dart';
import 'package:could_be/domain/entities/issue/issues_with_whole_categories.dart';
import 'package:could_be/domain/useCases/issue/fetch_issues_use_case.dart';
import 'package:could_be/domain/useCases/issue/manage_issue_evaluation_use_case.dart';
import 'package:could_be/domain/useCases/issue/search_issues_use_case.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_state.dart';
import 'package:could_be/presentation/main_feed/main_feed_state.dart';
import 'package:flutter/cupertino.dart';

class MainFeedViewModel with ChangeNotifier {
  final FetchIssuesUseCase _fetchIssuesUseCase;
  final SearchIssuesUseCase _searchIssuesUseCase;
  //상태
  MainFeedState _state = MainFeedState(
    issuesWithWholeCategories: IssuesWithWholeCategories.empty()
  );

  MainFeedState get state => _state;

  MainFeedViewModel({
    required FetchIssuesUseCase fetchIssuesUseCase,
    required SearchIssuesUseCase searchIssuesUseCase,
  }) : _fetchIssuesUseCase = fetchIssuesUseCase,
       _searchIssuesUseCase = searchIssuesUseCase {
    fetchIssuesWithWholeCategories();
  }

  void fetchIssuesWithWholeCategories() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final IssuesWithWholeCategories result = await _fetchIssuesUseCase.fetchIssuesWithWholeCategories(issueType: state.issueType);
    _state = state.copyWith(
      issuesWithWholeCategories: result,
      isLoading: false,
    );
    notifyListeners();
  }

  void changeQueryParam(IssueQueryParam issueQueryParam) {
    _state = state.copyWith(issueQueryParam: issueQueryParam);
    notifyListeners();
    _fetchQueryParamIssues(issueQueryParam);
  }

  void _fetchQueryParamIssues(IssueQueryParam issueQueryParam) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssuesUseCase.fetchIssuesWithWholeCategories(issueType: issueQueryParam.queryParam);
    _state = state.copyWith(
      issuesWithWholeCategories: result,
      isLoading: false,
    );
    notifyListeners();
  }

  // Future<dynamic> _fetchIssuesByType({
  //   String? lastIssueId,
  //   String? topicId, IssueQueryParam? issueQueryParam}) async {
  //   if(issueQueryParam != null) {
  //     _state = state.copyWith(query: null);
  //     return await _fetchIssuesUseCase.fetchQueryParamIssues(issueQueryParam, lastIssueId: lastIssueId);
  //   }else if(topicId != null){
  //     _state = state.copyWith(query: null);
  //     return await _fetchIssuesUseCase.fetchIssuesByTopicId(topicId, lastIssueId: lastIssueId);
  //   }else{
  //     _state = state.copyWith(query: null);
  //     switch (_issueType) {
  //       case IssueType.daily:
  //         return await _fetchIssuesUseCase.fetchDailyIssues(lastIssueId: lastIssueId);
  //       case IssueType.blindSpotLeft:
  //         return await _fetchIssuesUseCase.fetchBlindSpotLeftIssues(lastIssueId: lastIssueId);
  //       case IssueType.blindSpotRight:
  //         return await _fetchIssuesUseCase.fetchBlindSpotRightIssues(lastIssueId: lastIssueId);
  //       case IssueType.forYou:
  //         return await _fetchIssuesUseCase.fetchForYouIssues(lastIssueId: lastIssueId);
  //       case IssueType.hot:
  //         return await _fetchIssuesUseCase.fetchHotIssues(lastIssueId: lastIssueId);
  //       case IssueType.watchHistroy:
  //         return await _fetchIssuesUseCase.fetchWatchHistoryIssues(lastIssueId: lastIssueId);
  //       case IssueType.subscribed:
  //         return await _fetchIssuesUseCase.fetchSubscribedIssues(lastIssueId: lastIssueId);
  //       case IssueType.subscribedTopicIssuesWhole:
  //         return await _fetchIssuesUseCase.fetchSubscribedTopicIssuesWhole(lastIssueId: lastIssueId);
  //       case IssueType.subscribedTopicIssuesSpecific:
  //         return await _fetchIssuesUseCase.fetchIssuesByTopicId(topicId!, lastIssueId: lastIssueId);
  //       case IssueType.evaluated:
  //         return await _fetchIssuesUseCase.fetchIssuesEvaluated(lastIssueId: lastIssueId);
  //     }
  //   }
  // }
  //
  // void fetchInitalIssues({
  //   String? topicId,
  //   IssueQueryParam? issueQueryParam,
  // }) async {
  //   _state = state.copyWith(isLoading: true, query: null);
  //   notifyListeners();
  //   final Issues result = await _fetchIssuesByType(
  //     topicId: topicId,
  //     issueQueryParam: issueQueryParam,
  //   );
  //   _state = state.copyWith(
  //     issueList: result.issues,
  //     hasMore: result.hasMore,
  //     lastIssueId: result.lastIssueId,
  //     isLoading: false,
  //   );
  //   notifyListeners();
  // }
  //
  // Future<void> searchIssues(String query) async {
  //   _state = state.copyWith(isLoading: true);
  //   notifyListeners();
  //   final Issues result = await _searchIssuesUseCase.searchIssues(query);
  //   _state = state.copyWith(
  //     query: query,
  //     issueList: result.issues,
  //     hasMore: result.hasMore,
  //     lastIssueId: result.lastIssueId,
  //     isLoading: false,
  //   );
  //   notifyListeners();
  // }
}
