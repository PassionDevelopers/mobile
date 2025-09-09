import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/manage_issue_evaluation_interface.dart';

class ManageIssueEvaluationUseCase {
  final ManageIssueEvaluationRepository _manageIssueEvaluationRepository;
  ManageIssueEvaluationUseCase(this._manageIssueEvaluationRepository);

  Future<void> evaluateIssue({required String issueId, required Bias bias})async{
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageIssueEvaluation,
      parameters: {
        AnalyticsParameterKeys.issueId: issueId,
        AnalyticsParameterKeys.bias: bias.name,
        AnalyticsParameterKeys.perspective: bias.toPerspective(),
      },
    );
    await _manageIssueEvaluationRepository.evaluateIssue(
      issueId: issueId,
      perspective: bias.toPerspective()
    );
  }

  // Future<void> updateIssueEvaluation({required String issueId, required Bias bias})async{
  //   await _manageIssueEvaluationRepository.updateIssueEvaluation(
  //     issueId: issueId,
  //     perspective: bias.toPerspective()
  //   );
  // }
  //
  // Future<void> deleteIssueEvaluation({required String issueId})async{
  //   await _manageIssueEvaluationRepository.deleteIssueEvaluation(issueId: issueId);
  // }

}