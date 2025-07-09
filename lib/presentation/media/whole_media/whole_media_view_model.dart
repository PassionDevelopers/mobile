
import 'package:could_be/core/events/media_subscription_events.dart';
import 'package:could_be/domain/useCases/fetch_sources_use_case.dart';
import 'package:could_be/domain/useCases/manage_media_subscription_use_case.dart';
import 'package:could_be/presentation/media/whole_media/whole_media_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/entities/sources.dart';
import '../../../ui/color.dart';

class WholeMediaViewModel with ChangeNotifier{
  final FetchSourcesUseCase _fetchSourcesUseCase;
  final ManageMediaSubscriptionUseCase _manageMediaSubscriptionUseCase;

  // 상태
  WholeMediaState _state = WholeMediaState();
  WholeMediaState get state => _state;

  WholeMediaViewModel({
    required FetchSourcesUseCase fetchSourcesUseCase,
    required ManageMediaSubscriptionUseCase manageMediaSubscriptionUseCase,
  }) : _fetchSourcesUseCase = fetchSourcesUseCase,
       _manageMediaSubscriptionUseCase = manageMediaSubscriptionUseCase {
    _fetchAllSources();
  }

  void manageSourceSubscriptionBySourceId(String sourceId) async {
    final source = state.sources!.sources.firstWhere((source) => source.id == sourceId);
    if(source.isSubscribed) {
      await _manageMediaSubscriptionUseCase.unsubscribeSourceBySourceId(sourceId);
      MediaSubscriptionEvents.notifyMediaUnsubscribed(sourceId);
    } else {
      await _manageMediaSubscriptionUseCase.subscribeSouceBySouceId(sourceId);
      MediaSubscriptionEvents.notifyMediaSubscribed(sourceId);
    }

    Fluttertoast.showToast(
        msg: source.isSubscribed?
        "관심 언론에서 해제하였습니다."
            : "관심 언론으로 등록하였습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.gray3,
        textColor: AppColors.white,
        fontSize: 16.0
    );

    _state = state.copyWith(
        sources: Sources(
          sources: state.sources!.sources.map((source) {
            if (source.id == sourceId) {
              return source.copyWith(isSubscribed: !source.isSubscribed);
            }
            return source;
          }).toList(),
        )
    );
    notifyListeners();
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