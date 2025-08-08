import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';

import '../entities/media.dart';
import '../repositoryInterfaces/media_interface.dart';

class FetchMediaUseCase {
  final MediaRepository _mediaRepository;

  FetchMediaUseCase(this._mediaRepository);

  Future<Media> fetchSubscribedMedia() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchSubscribedMedia,
    );
    return await _mediaRepository.fetchSubscribedMedia();
  }
}

