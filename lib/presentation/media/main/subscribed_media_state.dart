import '../../../domain/entities/media.dart';

class SubscribedMediaState {
  final Media? media;
  final bool isLoading;

  SubscribedMediaState({
    this.media,
    this.isLoading = false,
  });

  SubscribedMediaState copyWith({
    Media? media,
    bool? isLoading,
  }) {
    return SubscribedMediaState(
      media: media ?? this.media,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}