import 'package:could_be/domain/useCases/fetch_source_detail_use_case.dart';
import 'package:could_be/presentation/media/media_detail/media_detail_state.dart';
import 'package:flutter/cupertino.dart';

class MediaDetailViewModel with ChangeNotifier {
  final FetchSourceDetailUseCase _fetchSourceDetailUseCase;

  MediaDetailViewModel({
    required String sourceId,
    required FetchSourceDetailUseCase fetchSourceDetailUseCase,
  }) : _fetchSourceDetailUseCase = fetchSourceDetailUseCase{
    _fetchSourceDetail(sourceId);
  }

  MediaDetailState _state = MediaDetailState();

  MediaDetailState get state => _state;

  Future<void> _fetchSourceDetail(String sourceId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchSourceDetailUseCase.fetchSourceDetailById(sourceId);

    _state = state.copyWith(
      sourceDetail: result,
      isLoading: false,
    );

    notifyListeners();
  }
}
