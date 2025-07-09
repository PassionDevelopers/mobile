import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../entities/source_detail.dart';
import '../repositoryInterfaces/source_detail_interface.dart';

class FetchSourceDetailUseCase {
  final SourceDetailRepository _sourceDetailRepository;

  FetchSourceDetailUseCase(this._sourceDetailRepository);

  Future<SourceDetail> fetchSourceDetailById(String sourceId) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSourceDetailById);
    return await _sourceDetailRepository.fetchSourceDetailById(sourceId);
  }
}