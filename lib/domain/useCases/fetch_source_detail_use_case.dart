import '../entities/source_detail.dart';
import '../repositoryInterfaces/source_detail_interface.dart';

class FetchSourceDetailUseCase {
  final SourceDetailRepository _sourceDetailRepository;

  FetchSourceDetailUseCase(this._sourceDetailRepository);

  Future<SourceDetail> fetchSourceDetailById(String sourceId) async {
    return await _sourceDetailRepository.fetchSourceDetailById(sourceId);
  }
}