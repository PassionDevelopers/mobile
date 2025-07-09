

import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../entities/media.dart';
import '../repositoryInterfaces/media_interface.dart';

class FetchMediaUseCase {
  final MediaRepository _mediaRepository;

  FetchMediaUseCase(this._mediaRepository);

  Future<Media> fetchSubscribedMedia() async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchSubscribedMedia);
    return await _mediaRepository.fetchSubscribedMedia();
  }
}

