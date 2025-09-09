import '../../../domain/entities/source/source_detail.dart';

class MediaDetailState{
  final bool isLoading;
  final bool isSubscribeLoading;
  final bool isVoteLoading;
  final SourceDetail? sourceDetail;

  MediaDetailState({
    this.isLoading = false,
    this.sourceDetail,
    this.isSubscribeLoading = false,
    this.isVoteLoading = false,
  });

  MediaDetailState copyWith({
    bool? isLoading,
    SourceDetail? sourceDetail,
    bool? isSubscribeLoading,
    bool? isVoteLoading,
  }) {
    return MediaDetailState(
      isLoading: isLoading ?? this.isLoading,
      sourceDetail: sourceDetail ?? this.sourceDetail,
      isSubscribeLoading: isSubscribeLoading ?? this.isSubscribeLoading,
      isVoteLoading: isVoteLoading ?? this.isVoteLoading,
    );
  }
}