import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';

import '../entities/source_detail.dart';
import '../repositoryInterfaces/source/source_detail_interface.dart';

class FetchSourceDetailUseCase {
  final SourceDetailRepository _sourceDetailRepository;

  FetchSourceDetailUseCase(this._sourceDetailRepository);

  Future<SourceDetail> fetchSourceDetailById(String sourceId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchSourceDetail,
      parameters: {
        AnalyticsParameterKeys.sourceId: sourceId,
      },
    );
    return await _sourceDetailRepository.fetchSourceDetailById(sourceId);
  }
}