

import 'package:could_be/domain/useCases/fetch_sources_use_case.dart';
import 'package:could_be/presentation/media/whole_media/whole_media_state.dart';
import 'package:flutter/cupertino.dart';

class WholeMediaViewModel with ChangeNotifier{
  final FetchSourcesUseCase _fetchSourcesUseCase;

  // 상태
  WholeMediaState _state = WholeMediaState();
  WholeMediaState get state => _state;

  WholeMediaViewModel({
    required FetchSourcesUseCase fetchSourcesUseCase,
  }) : _fetchSourcesUseCase = fetchSourcesUseCase {
    _fetchAllSources();
  }

  void _fetchAllSources() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchSourcesUseCase.fetchAllSources();
    _state = state.copyWith(
      sources: result,
      isLoading: false,
    );

    notifyListeners();
  }
}