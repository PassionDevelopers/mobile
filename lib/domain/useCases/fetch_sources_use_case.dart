

import '../entities/sources.dart';
import '../repositoryInterfaces/sources_interface.dart';

class FetchSourcesUseCase {
  final SourcesRepository _sourcesRepository;

  FetchSourcesUseCase(this._sourcesRepository);

  Future<Sources> fetchSubscribedSources()async{
    return await _sourcesRepository.fetchSubscribedSources();
  }

  Future<Sources>fetchAllSources()async{
    return await _sourcesRepository.fetchAllSources();
  }
}