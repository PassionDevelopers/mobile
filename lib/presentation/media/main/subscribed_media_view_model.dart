

import 'package:could_be/presentation/media/main/subscribed_media_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/useCases/fetch_media_use_case.dart';

class SubscribedMediaViewModel with ChangeNotifier{
  final FetchMediaUseCase _fetchMediaUseCase;

  SubscribedMediaState _state = SubscribedMediaState();
  SubscribedMediaState get state => _state;

  SubscribedMediaViewModel({
    required FetchMediaUseCase fetchMediaUseCase,
  }) : _fetchMediaUseCase = fetchMediaUseCase {
    _fetchSubscribedMedia();
  }

  void _fetchSubscribedMedia() async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchMediaUseCase.fetchSubscribedMedia();

    _state = state.copyWith(
      media: result,
      isLoading: false,
    );

    notifyListeners();
  }
}