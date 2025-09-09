import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/entities/issue/issues.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issues_interface.dart';


class SearchIssuesUseCase {
  final IssuesRepository _issuesRepository;

  SearchIssuesUseCase(this._issuesRepository);

  Future<Issues> searchIssues(String query) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.searchIssues,
      parameters: {
        AnalyticsParameterKeys.searchTerm: query,
        AnalyticsParameterKeys.searchType: AnalyticsParameterKeys.searchTypeIssue,
      },
    );
    return await _issuesRepository.searchIssues(query);
  }
}