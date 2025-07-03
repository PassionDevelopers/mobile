import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_evaluation_interface.dart';

class ManageIssueEvaluationUseCase {
  final ManageIssueEvaluationRepository _manageIssueEvaluationRepository;
  ManageIssueEvaluationUseCase(this._manageIssueEvaluationRepository);

  Future<void> evaluateIssue({required String issueId, required Bias bias})async{
    await _manageIssueEvaluationRepository.evaluateIssue(
      issueId: issueId,
      perspective: bias.toPerspective()
    );
  }

  Future<void> updateIssueEvaluation({required String issueId, required Bias bias})async{
    await _manageIssueEvaluationRepository.updateIssueEvaluation(
      issueId: issueId,
      perspective: bias.toPerspective()
    );
  }

  Future<void> deleteIssueEvaluation({required String issueId})async{
    await _manageIssueEvaluationRepository.deleteIssueEvaluation(issueId: issueId);
  }

}