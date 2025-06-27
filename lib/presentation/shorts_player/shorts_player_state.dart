import '../../domain/entities/issue_detail.dart';
import 'shorts_player_view_model.dart';

class ShortsPlayerState {
  final List<IssueDetail> contents;
  final int currentIndex;
  final bool isLoading;
  final bool hasMore;
  final bool isLoadingMore;

  ShortsPlayerState({
    this.contents = const [],
    this.currentIndex = 0,
    this.isLoading = false,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  ShortsPlayerState copyWith({
    List<IssueDetail>? contents,
    int? currentIndex,
    bool? isLoading,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ShortsPlayerState(
      contents: contents ?? this.contents,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}