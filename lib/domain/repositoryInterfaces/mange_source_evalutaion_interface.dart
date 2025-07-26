abstract class ManageSourceEvaluationRepository {

  Future<void> evaluateSource({
    required String sourceId,
    required String perspective,
  });

}