import 'package:could_be/domain/repositoryInterfaces/mange_source_evalutaion_interface.dart';

class ManageSourceEvaluationUseCase{

  final ManageSourceEvaluationRepository _manageSourceEvaluationRepository;
  ManageSourceEvaluationUseCase(this._manageSourceEvaluationRepository);

  Future<void> manageSourceEvaluation({
    required String sourceId,
    required String perspective,
  }) async {
    await _manageSourceEvaluationRepository.evaluateSource(
      sourceId: sourceId,
      perspective: perspective,
    );
  }
}