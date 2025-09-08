
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import '../entities/sources.dart';
import '../repositoryInterfaces/source/sources_interface.dart';

class FetchSourcesUseCase {
  final SourcesRepository _sourcesRepository;

  FetchSourcesUseCase(this._sourcesRepository);

  Future<Sources> fetchSubscribedSources()async{
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchSubscribedSources,
    );
    return await _sourcesRepository.fetchSubscribedSources();
  }

  Future<Sources>fetchAllSources()async{
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchAllSources,
    );
    return await _sourcesRepository.fetchAllSources();
  }

  Future<Sources> fetchEvaluatedSources()async{
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchEvaluatedSources,
    );
    return await _sourcesRepository.fetchEvaluatedSources();
  }
}