import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';

enum CommentSortType {
  latest('최신순'),
  popular('인기순');

  const CommentSortType(this.displayName);
  final String displayName;
}


class CommentState{
  String? parentId;
  final String issueId;
  UserProfile? userProfile;

  // State variables
  List<Comment> comments = [];
  bool hasMore = false;
  String? lastCommentId;
  int commentsCount = 0;
  CommentSortType selectedSortType = CommentSortType.popular;

  // Getters
  bool isLoading = false;
  bool isLoadingMore = false;
  CommentState({required this.issueId});

  CommentState copyWith({
    String? parentId,
    UserProfile? userProfile,
    List<Comment>? comments,
    bool? hasMore,
    String? lastCommentId,
    CommentSortType? selectedSortType,
    bool? isLoading,
    bool? isLoadingMore,
    int? commentsCount,
  }) {
    return CommentState(issueId: issueId)
      ..parentId = parentId ?? this.parentId
      ..userProfile = userProfile ?? this.userProfile
      ..comments = comments ?? this.comments
      ..hasMore = hasMore ?? this.hasMore
      ..lastCommentId = lastCommentId ?? this.lastCommentId
      ..selectedSortType = selectedSortType ?? this.selectedSortType
      ..isLoading = isLoading ?? this.isLoading
      ..isLoadingMore = isLoadingMore ?? this.isLoadingMore
      ..commentsCount = commentsCount ?? this.commentsCount;
  }
}