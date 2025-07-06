import 'dart:async';
import 'dart:developer';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/domain/useCases/fetch_whole_issue_use_case.dart';
import 'package:flutter/material.dart';
import 'shorts_player_state.dart';

class ShortsPlayerViewModel extends ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  ShortsPlayerState _state = ShortsPlayerState();

  ShortsPlayerViewModel({
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required String issueId
  }) : _fetchIssueDetailUseCase = fetchIssueDetailUseCase {
    loadInitialContent(issueId);
  }

  ShortsPlayerState get state => _state;
  List<IssueDetail> get issueDetail => _state.contents;
  int get currentIndex => _state.currentIndex;
  bool get isLoading => _state.isLoading;
  bool get hasMore => _state.hasMore;
  bool get isLoadingMore => _state.isLoadingMore;

  int _nextPageIndex = 0;
  final int _pageSize = 10;
  final int _preloadThreshold = 3;
  final int _maxCacheSize = 50; // 최대 캐시 크기
  final int _cacheRemoveCount = 10; // 한 번에 제거할 컨텐츠 수

  Timer? _preloadTimer;
  final Set<String> _loadingContentIds = {}; // 중복 로딩 방지

  @override
  void dispose() {
    _preloadTimer?.cancel();
    super.dispose();
  }

  Future<void> loadInitialContent(String issueId) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await _loadContent(issueId);
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void onPageChanged(int index) {
    _state = _state.copyWith(currentIndex: index);
    notifyListeners();
    
    _checkAndPreloadContent(index, _state.contents[index].id);
    _checkAndCleanupCache(index);
  }

  void _checkAndPreloadContent(int currentIndex, String issueId) {
    if (!_state.isLoadingMore && 
        _state.hasMore && 
        currentIndex >= _state.contents.length - _preloadThreshold) {
      _loadMoreContent(issueId);
    }
  }

  Future<void> _loadMoreContent(String issueId) async {
    if (_state.isLoadingMore || !_state.hasMore) return;
    
    _state = _state.copyWith(isLoadingMore: true);
    notifyListeners();
    try {
      await _loadContent(issueId);
    } finally {
      _state = _state.copyWith(isLoadingMore: false);
      notifyListeners();
    }
  }

  // void refreshContent() async {
  //   _state = ShortsPlayerState();
  //   _nextPageIndex = 0;
  //   _loadingContentIds.clear();
  //   notifyListeners();
  //   await loadInitialContent();
  // }

  void _checkAndCleanupCache(int currentIndex) {
    if (_state.contents.length > _maxCacheSize) {
      _cleanupOldContent(currentIndex);
    }
  }

  void _cleanupOldContent(int currentIndexValue) {
    final startRemoveIndex = currentIndexValue - (_maxCacheSize ~/ 2);
    if (startRemoveIndex > _cacheRemoveCount) {
      final updatedContents = List<IssueDetail>.from(_state.contents);
      for (int i = 0; i < _cacheRemoveCount; i++) {
        if (updatedContents.isNotEmpty) {
          final removedContent = updatedContents.removeAt(0);
          _loadingContentIds.remove(removedContent.id);
        }
      }
      _state = _state.copyWith(
        contents: updatedContents,
        currentIndex: _state.currentIndex - _cacheRemoveCount,
      );
      notifyListeners();
    }
  }

  bool _shouldPreloadContent(int currentIndex) {
    return !_state.isLoadingMore && 
           _state.hasMore && 
           currentIndex >= _state.contents.length - _preloadThreshold;
  }

  Future<void> _loadContent(String issueId) async {
    final batchIds = List.generate(
      _pageSize, 
      (index) => 'news_${_nextPageIndex + index}'
    );
    
    final newIds = batchIds.where((id) => !_loadingContentIds.contains(id)).toList();
    
    if (newIds.isEmpty) return;
    
    _loadingContentIds.addAll(newIds);
    
    try {
      log(issueId);
      final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);
      
      final newContents = List.generate(
        newIds.length,
        (index) => result!,
      );
      
      final updatedContents = List<IssueDetail>.from(_state.contents);
      updatedContents.addAll(newContents);
      _nextPageIndex += newIds.length;
      
      _state = _state.copyWith(
        contents: updatedContents,
        hasMore: _nextPageIndex < 100,
      );
      notifyListeners();
    } catch (error) {
      _loadingContentIds.removeAll(newIds);
      rethrow;
    }
  }

  void preloadNextContent() {
    if (_shouldPreloadContent(_state.currentIndex)) {
      _loadMoreContent(_state.contents[_state.currentIndex].nextIssueIds.first);
    }
  }

  int get cacheSize => _state.contents.length;
  bool get canLoadMore => _state.hasMore && !_state.isLoadingMore;

  void toggleSubscription(String contentId) {
    final updatedContents = _state.contents.map((content) {
      if (content.id == contentId) {
        return content.copyWith(
          userEvaluation: content.userEvaluation,
            isSubscribed: !content.isSubscribed);
      }
      return content;
    }).toList();
    
    _state = _state.copyWith(contents: updatedContents);
    notifyListeners();
  }

  void shareContent(IssueDetail content) {
    // TODO: Implement share functionality
    print('Sharing content: ${content.title}');
  }

  void viewOriginalArticle(IssueDetail content) {
    // TODO: Implement navigation to web view
    print('Viewing original article: ${content.id}');
  }

  void analyzeDifference(IssueDetail content) {
    // TODO: Implement bias analysis view
    print('Analyzing difference for: ${content.id}');
  }
}