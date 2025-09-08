
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issue_query_params_interface.dart';

class FetchIssueQueryParamsUseCase{
  final IssueQueryParamsRepository _issueQueryParamsRepository;
  FetchIssueQueryParamsUseCase(this._issueQueryParamsRepository);

  Future<IssueQueryParams> fetchIssueQueryParams() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchIssueQueryParams,
    );
    return await _issueQueryParamsRepository.fetchIssueQueryParams();
  }
}