
import 'package:could_be/domain/entities/issue/hot_issues.dart';

class HotIssuesState{
  final HotIssues? hotIssues;
  final bool isLoading;

  HotIssuesState({
    this.hotIssues,
    this.isLoading = false,
  });

  HotIssuesState copyWith({
    HotIssues? hotIssues,
    bool? isLoading,
  }) {
    return HotIssuesState(
      hotIssues: hotIssues ?? this.hotIssues,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}