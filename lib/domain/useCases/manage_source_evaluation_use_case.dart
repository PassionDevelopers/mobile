import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/repositoryInterfaces/source/mange_source_evalutaion_interface.dart';

class ManageSourceEvaluationUseCase{

  final ManageSourceEvaluationRepository _manageSourceEvaluationRepository;
  ManageSourceEvaluationUseCase(this._manageSourceEvaluationRepository);

  Future<void> manageSourceEvaluation({
    required String sourceId,
    required String perspective,
  }) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.manageSourceEvaluation,
      parameters: {
        AnalyticsParameterKeys.sourceId: sourceId,
        'perspective': perspective,
      },
    );
    await _manageSourceEvaluationRepository.evaluateSource(
      sourceId: sourceId,
      perspective: perspective,
    );
  }
}