import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';

import '../entities/issue_detail.dart';
import '../repositoryInterfaces/issue_detail_interface.dart';

class FetchIssueDetailUseCase{
  final IssueDetailRepository _issueDetailRepository;

  const FetchIssueDetailUseCase(this._issueDetailRepository);

  Future<IssueDetail?> fetchIssueDetailById(String id) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchIssueDetail,
      parameters: {
        AnalyticsParameterKeys.issueId: id,
      },
    );
    return _issueDetailRepository.fetchIssueDetailById(id);
  }
}