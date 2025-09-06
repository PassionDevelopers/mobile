import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/domain/repositoryInterfaces/hot_issues_interface.dart';

class FetchHotIssuesUseCase {
  final HotIssuesRepository _repository;

  FetchHotIssuesUseCase(this._repository);

  Future<HotIssues> fetchHotIssues({String? lastIssueId}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchHotIssues,
      parameters: {
        'last_issue_id': lastIssueId ?? '',
      },
    );
    return await _repository.fetchHotIssues(lastIssueId: lastIssueId,);
  }

}