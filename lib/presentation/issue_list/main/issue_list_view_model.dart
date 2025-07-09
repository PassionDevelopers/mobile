import 'dart:developer';

import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/domain/entities/issue.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/entities/issues.dart';
import 'package:could_be/domain/useCases/fetch_issues_use_case.dart';
import 'package:could_be/domain/useCases/manage_issue_evaluation_use_case.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_state.dart';
import 'package:flutter/cupertino.dart';
import '../issue_type.dart';

class IssueListViewModel with ChangeNotifier {
  final FetchIssuesUseCase _fetchIssuesUseCase;
  final ManageIssueEvaluationUseCase _manageIssueEvaluationUseCase;
  final IssueType _issueType;

  //상태
  IssueListState _state = IssueListState();
  IssueListState get state => _state;

  IssueListViewModel({
    required FetchIssuesUseCase fetchIssuesUseCase,
    required ManageIssueEvaluationUseCase manageIssueEvaluationUseCase,
    required IssueType issueType,
    String? topicId,
  })  : _fetchIssuesUseCase = fetchIssuesUseCase,
        _manageIssueEvaluationUseCase = manageIssueEvaluationUseCase,
        _issueType = issueType {
    fetchInitalIssues(topicId: topicId);
  }

  void manageIssueEvaluation({required Bias bias, required int index}) async {
    if(state.isEvaluating) return;
    _state = state.copyWith(isEvaluating: true);
    notifyListeners();
    final Issue issue = state.issueList[index];
    if (issue.userEvaluatedPerspective != null) {
      if(issue.userEvaluatedPerspective == bias.toPerspective()) {
        log('Bias is already ${issue.userEvaluatedPerspective}, deleting evaluation');
        await _manageIssueEvaluationUseCase.deleteIssueEvaluation(issueId: issue.id);
        _state = state.copyWith(
          issueList: List.from(state.issueList)..[index] = issue.copyWith(
            userEvaluatedPerspective: null,
            leftLikeCount: issue.leftLikeCount - (bias == Bias.left ? 1 : 0),
            rightLikeCount: issue.rightLikeCount - (bias == Bias.right ? 1 : 0),
            centerLikeCount: issue.centerLikeCount - (bias == Bias.center ? 1 : 0),
          ),
        );
      }else{
        log('Bias changed from ${issue.userEvaluatedPerspective} to $bias');
        await _manageIssueEvaluationUseCase.updateIssueEvaluation(issueId: issue.id, bias: bias);
        _state = state.copyWith(
          issueList: List.from(state.issueList)..[index] = issue.copyWith(
            userEvaluatedPerspective: bias.toPerspective(),
            leftLikeCount: issue.leftLikeCount + (bias == Bias.left ? 1 : 0) - (issue.userEvaluatedPerspective == Bias.left.toPerspective() ? 1 : 0),
            rightLikeCount: issue.rightLikeCount + (bias == Bias.right ? 1 : 0) - (issue.userEvaluatedPerspective == Bias.right.toPerspective() ? 1 : 0),
            centerLikeCount: issue.centerLikeCount + (bias == Bias.center ? 1 : 0) - (issue.userEvaluatedPerspective == Bias.center.toPerspective() ? 1 : 0),
          ),
        );
      }
    } else {
      log('Bias selected: $bias, evaluating issue');
      await _manageIssueEvaluationUseCase.evaluateIssue(issueId: issue.id, bias: bias);
      _state = state.copyWith(
        issueList: List.from(state.issueList)..[index] = issue.copyWith(
          userEvaluatedPerspective: bias.toPerspective(),
          leftLikeCount: issue.leftLikeCount + (bias == Bias.left ? 1 : 0),
          rightLikeCount: issue.rightLikeCount + (bias == Bias.right ? 1 : 0),
          centerLikeCount: issue.centerLikeCount + (bias == Bias.center ? 1 : 0),
        ),
      );
    }
    _state = state.copyWith(isEvaluating: false);
    notifyListeners();
  }

  void changeQueryParam(IssueQueryParam issueQueryParam) {
    _state = state.copyWith(issueQueryParam: issueQueryParam);
    notifyListeners();
    _fetchQueryParamIssues(issueQueryParam);
  }

  void changeTopicId(String? topicId) {
    _state = state.copyWith(topicId: topicId);
    notifyListeners();
    fetchInitalIssues(topicId: topicId);
  }

  void _fetchQueryParamIssues(IssueQueryParam issueQueryParam) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final Issues result = await _fetchIssuesByType(issueQueryParam: issueQueryParam);
    _state = state.copyWith(
      issueList: result.issues,
      hasMore: result.hasMore,
      lastIssueId: result.lastIssueId,
      isLoading: false,
    );
    notifyListeners();
  }

  void fetchInitalIssues({String? topicId}) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final Issues result = await _fetchIssuesByType(topicId: topicId);
    _state = state.copyWith(
      issueList: result.issues,
      hasMore: result.hasMore,
      lastIssueId: result.lastIssueId,
      isLoading: false,
    );
    notifyListeners();
  }

  void fetchMoreIssues({required String lastIssueId, String? topicId}) async {
    if(_state.isLoadingMore || !_state.hasMore || _state.issueList.length >=50) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();

    final Issues result = await _fetchIssuesByType(
        lastIssueId: lastIssueId,
        topicId: topicId, issueQueryParam: state.issueQueryParam);
    List<Issue> newIssueList = state.issueList + result.issues;
    if(newIssueList.length > 50) {
      newIssueList = newIssueList.sublist(newIssueList.length-50);
    }
    _state = state.copyWith(
      issueList: newIssueList,
      hasMore: result.hasMore,
      lastIssueId: result.lastIssueId,
      isLoadingMore: false,
    );
    notifyListeners();
  }

  Future<dynamic> _fetchIssuesByType({
    String? lastIssueId,
    String? topicId, IssueQueryParam? issueQueryParam}) async {
    if(issueQueryParam != null) {
      return await _fetchIssuesUseCase.fetchQueryParamIssues(issueQueryParam, lastIssueId: lastIssueId);
    }else if(topicId != null){
      return await _fetchIssuesUseCase.fetchIssuesByTopicId(topicId, lastIssueId: lastIssueId);
    }else{
      switch (_issueType) {
        case IssueType.daily:
          return await _fetchIssuesUseCase.fetchDailyIssues(lastIssueId: lastIssueId);
        case IssueType.blindSpotLeft:
          return await _fetchIssuesUseCase.fetchBlindSpotLeftIssues(lastIssueId: lastIssueId);
        case IssueType.blindSpotRight:
          return await _fetchIssuesUseCase.fetchBlindSpotRightIssues(lastIssueId: lastIssueId);
        case IssueType.forYou:
          return await _fetchIssuesUseCase.fetchForYouIssues(lastIssueId: lastIssueId);
        case IssueType.hot:
          return await _fetchIssuesUseCase.fetchHotIssues(lastIssueId: lastIssueId);
        case IssueType.watchHistroy:
          return await _fetchIssuesUseCase.fetchWatchHistoryIssues(lastIssueId: lastIssueId);
        case IssueType.subscribed:
          return await _fetchIssuesUseCase.fetchSubscribedIssues(lastIssueId: lastIssueId);
        case IssueType.subscribedTopicIssuesWhole:
          return await _fetchIssuesUseCase.fetchSubscribedTopicIssuesWhole(lastIssueId: lastIssueId);
        case IssueType.subscribedTopicIssuesSpecific:
          return await _fetchIssuesUseCase.fetchIssuesByTopicId(topicId!, lastIssueId: lastIssueId);
        case IssueType.evaluated:
          return await _fetchIssuesUseCase.fetchIssuesEvaluated(lastIssueId: lastIssueId);
      }
    }
  }

  // void onPageChanged(int index) {
  //   _state = _state.copyWith(currentIndex: index);
  //   notifyListeners();
  //
  //   _checkAndPreloadContent(index, _state.contents[index].id);
  //   _checkAndCleanupCache(index);
  // }
  //
  // void _checkAndPreloadContent(int currentIndex, String issueId) {
  //   if (!_state.isLoadingMore &&
  //       _state.hasMore &&
  //       currentIndex >= _state.contents.length - _preloadThreshold) {
  //     _loadMoreContent(issueId);
  //   }
  // }
  //
  // Future<void> _loadMoreContent(String issueId) async {
  //   if (_state.isLoadingMore || !_state.hasMore) return;
  //
  //   _state = _state.copyWith(isLoadingMore: true);
  //   notifyListeners();
  //   try {
  //     await _loadContent(issueId);
  //   } finally {
  //     _state = _state.copyWith(isLoadingMore: false);
  //     notifyListeners();
  //   }
  // }
  //
  // // void refreshContent() async {
  // //   _state = ShortsPlayerState();
  // //   _nextPageIndex = 0;
  // //   _loadingContentIds.clear();
  // //   notifyListeners();
  // //   await loadInitialContent();
  // // }
  //
  // void _checkAndCleanupCache(int currentIndex) {
  //   if (_state.contents.length > _maxCacheSize) {
  //     _cleanupOldContent(currentIndex);
  //   }
  // }
  //
  // void _cleanupOldContent(int currentIndexValue) {
  //   final startRemoveIndex = currentIndexValue - (_maxCacheSize ~/ 2);
  //   if (startRemoveIndex > _cacheRemoveCount) {
  //     final updatedContents = List<IssueDetail>.from(_state.contents);
  //     for (int i = 0; i < _cacheRemoveCount; i++) {
  //       if (updatedContents.isNotEmpty) {
  //         final removedContent = updatedContents.removeAt(0);
  //         _loadingContentIds.remove(removedContent.id);
  //       }
  //     }
  //     _state = _state.copyWith(
  //       contents: updatedContents,
  //       currentIndex: _state.currentIndex - _cacheRemoveCount,
  //     );
  //     notifyListeners();
  //   }
  // }
  //
  // bool _shouldPreloadContent(int currentIndex) {
  //   return !_state.isLoadingMore &&
  //       _state.hasMore &&
  //       currentIndex >= _state.contents.length - _preloadThreshold;
  // }
  //
  // Future<void> _loadContent(String issueId) async {
  //   final batchIds = List.generate(
  //       _pageSize,
  //           (index) => 'news_${_nextPageIndex + index}'
  //   );
  //
  //   final newIds = batchIds.where((id) => !_loadingContentIds.contains(id)).toList();
  //
  //   if (newIds.isEmpty) return;
  //
  //   _loadingContentIds.addAll(newIds);
  //
  //   try {
  //     log(issueId);
  //     final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);
  //
  //     final newContents = List.generate(
  //       newIds.length,
  //           (index) => result!,
  //     );
  //
  //     final updatedContents = List<IssueDetail>.from(_state.contents);
  //     updatedContents.addAll(newContents);
  //     _nextPageIndex += newIds.length;
  //
  //     _state = _state.copyWith(
  //       contents: updatedContents,
  //       hasMore: _nextPageIndex < 100,
  //     );
  //     notifyListeners();
  //   } catch (error) {
  //     _loadingContentIds.removeAll(newIds);
  //     rethrow;
  //   }
  // }
  //
  // void preloadNextContent() {
  //   if (_shouldPreloadContent(_state.currentIndex)) {
  //     _loadMoreContent(_state.contents[_state.currentIndex].nextIssueIds.first);
  //   }
  // }
} 