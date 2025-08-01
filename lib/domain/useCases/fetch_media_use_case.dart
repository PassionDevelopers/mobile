import '../entities/media.dart';
import '../repositoryInterfaces/media_interface.dart';

class FetchMediaUseCase {
  final MediaRepository _mediaRepository;

  FetchMediaUseCase(this._mediaRepository);

  Future<Media> fetchSubscribedMedia() async {
    return await _mediaRepository.fetchSubscribedMedia();
  }
}

