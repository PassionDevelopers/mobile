import '../../../domain/entities/source_detail.dart';

class MediaDetailState{
  final bool isLoading;
  final bool isSubscribeLoading;
  final bool isvoteLoading;
  final SourceDetail? sourceDetail;

  MediaDetailState({
    this.isLoading = false,
    this.sourceDetail,
    this.isSubscribeLoading = false,
    this.isvoteLoading = false,
  });

  MediaDetailState copyWith({
    bool? isLoading,
    SourceDetail? sourceDetail,
    bool? isSubscribeLoading,
    bool? isvoteLoading,
  }) {
    return MediaDetailState(
      isLoading: isLoading ?? this.isLoading,
      sourceDetail: sourceDetail ?? this.sourceDetail,
      isSubscribeLoading: isSubscribeLoading ?? this.isSubscribeLoading,
      isvoteLoading: isvoteLoading ?? this.isvoteLoading,
    );
  }
}