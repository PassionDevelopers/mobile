import '../entities/media.dart';

abstract class MediaRepository{
  Future<Media> fetchSubscribedMedia();
}