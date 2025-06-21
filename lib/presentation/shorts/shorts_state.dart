import 'package:could_be/domain/entities/whole_issue.dart';

class ShortsState{

  final WholeIssue? wholeIssue;
  final bool isLoading;

  ShortsState({
    this.isLoading = false,
    this.wholeIssue,
  });

  ShortsState copyWith({
    WholeIssue? wholeIssue,
    bool? isLoading,
  }) {
    return ShortsState(
      wholeIssue: wholeIssue ?? this.wholeIssue,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}