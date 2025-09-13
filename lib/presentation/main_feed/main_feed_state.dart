import 'package:could_be/domain/entities/issue/issue_query_params.dart';
import 'package:could_be/domain/entities/issue/issues_with_category.dart';
import 'package:could_be/domain/entities/issue/issues_with_whole_categories.dart';

class MainFeedState {
  final bool isLoading;
  final IssuesWithWholeCategories issuesWithWholeCategories;
  final IssueQueryParam? issueQueryParam;
  final String? issueType;

  MainFeedState({
    this.isLoading = false,
    this.issueQueryParam,
    required IssuesWithWholeCategories issuesWithWholeCategories,
    this.issueType,
  }) : issuesWithWholeCategories = issuesWithWholeCategories;

  MainFeedState copyWith({
    bool? isLoading,
    IssuesWithWholeCategories? issuesWithWholeCategories,
    IssueQueryParam? issueQueryParam,
    String? issueType,
  }) {
    return MainFeedState(
      isLoading: isLoading ?? this.isLoading,
      issueType: issueType ?? this.issueType,
      issueQueryParam: issueQueryParam ?? this.issueQueryParam,
      issuesWithWholeCategories: issuesWithWholeCategories ?? this.issuesWithWholeCategories,
    );
  }
}