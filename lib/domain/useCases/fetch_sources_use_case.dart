

import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../entities/sources.dart';
import '../repositoryInterfaces/sources_interface.dart';

class FetchSourcesUseCase {
  final SourcesRepository _sourcesRepository;

  FetchSourcesUseCase(this._sourcesRepository);

  Future<Sources> fetchSubscribedSources()async{
    getIt<Amplitude>().track(AmplitudeEvents.fetchSubscribedSources);
    return await _sourcesRepository.fetchSubscribedSources();
  }

  Future<Sources>fetchAllSources()async{
    getIt<Amplitude>().track(AmplitudeEvents.fetchAllSources);
    return await _sourcesRepository.fetchAllSources();
  }
}