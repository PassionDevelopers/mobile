

import 'package:could_be/domain/entities/issue/issues_with_category.dart';

class IssuesWithWholeCategories {
  final List<IssuesWithCategory> categories;

  final IssuesWithCategory politics;
  final IssuesWithCategory economy;
  final IssuesWithCategory society;
  final IssuesWithCategory culture;
  final IssuesWithCategory international;
  final IssuesWithCategory technology;

  IssuesWithWholeCategories(this.categories) :
    politics = categories.firstWhere((element) => element.category == 'politics', orElse: () => IssuesWithCategory(category: 'politics', issues: [], hasMore: false, lastIssueId: null)),
    economy = categories.firstWhere((element) => element.category == 'economy', orElse: () => IssuesWithCategory(category: 'economy', issues: [], hasMore: false, lastIssueId: null)),
    society = categories.firstWhere((element) => element.category == 'society', orElse: () => IssuesWithCategory(category: 'society', issues: [], hasMore: false, lastIssueId: null)),
    culture = categories.firstWhere((element) => element.category == 'culture', orElse: () => IssuesWithCategory(category: 'culture', issues: [], hasMore: false, lastIssueId: null)),
    international = categories.firstWhere((element) => element.category == 'international', orElse: () => IssuesWithCategory(category: 'international', issues: [], hasMore: false, lastIssueId: null)),
    technology = categories.firstWhere((element) => element.category == 'technology', orElse: () => IssuesWithCategory(category: 'technology', issues: [], hasMore: false, lastIssueId: null))
  ;

  static IssuesWithWholeCategories empty() {
    return IssuesWithWholeCategories([
      IssuesWithCategory(category: 'politics', issues: [], hasMore: false, lastIssueId: null),
      IssuesWithCategory(category: 'economy', issues: [], hasMore: false, lastIssueId: null),
      IssuesWithCategory(category: 'society', issues: [], hasMore: false, lastIssueId: null),
      IssuesWithCategory(category: 'culture', issues: [], hasMore: false, lastIssueId: null),
      IssuesWithCategory(category: 'international', issues: [], hasMore: false, lastIssueId: null),
      IssuesWithCategory(category: 'technology', issues: [], hasMore: false, lastIssueId: null),
    ]);
  }
}
