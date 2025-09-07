abstract class ManageIssueEvaluationRepository {
  Future<void> evaluateIssue({
    required String issueId,
    required String perspective,
  });

  Future<void> deleteIssueEvaluation({
    required String issueId,
  });

  Future<void> updateIssueEvaluation({
    required String issueId,
    required String perspective,
  });

}
