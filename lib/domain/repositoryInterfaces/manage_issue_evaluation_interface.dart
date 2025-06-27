abstract class ManageIssueEvaluationRepository {
  Future<void> evaluateIssue({
    required String issueId,
    required String perspective,
  });

  Future<void> unEvaluateIssue({
    required String issueId,
    required String perspective,
  });

  Future<void> updateIssueEvaluation({
    required String issueId,
    required String perspective,
  });

}
