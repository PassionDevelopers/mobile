import '../../../domain/entities/source_detail.dart';

class MediaDetailState{
  final bool isLoading;
  final SourceDetail? sourceDetail;

  MediaDetailState({
    this.isLoading = false,
    this.sourceDetail,
  });

  MediaDetailState copyWith({
    bool? isLoading,
    SourceDetail? sourceDetail,
  }) {
    return MediaDetailState(
      isLoading: isLoading ?? this.isLoading,
      sourceDetail: sourceDetail ?? this.sourceDetail,
    );
  }
}