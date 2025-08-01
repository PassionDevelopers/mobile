import 'dart:developer';

import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/domain/useCases/fetch_source_detail_use_case.dart';
import 'package:could_be/domain/useCases/manage_media_subscription_use_case.dart';
import 'package:could_be/domain/useCases/manage_source_evaluation_use_case.dart';
import 'package:could_be/presentation/media/media_detail/media_detail_state.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/events/media_subscription_events.dart';

class MediaDetailViewModel with ChangeNotifier {
  final FetchSourceDetailUseCase _fetchSourceDetailUseCase;
  final ManageMediaSubscriptionUseCase _manageMediaSubscriptionUseCase;
  final ManageSourceEvaluationUseCase _manageSourceEvaluationUseCase;

  MediaDetailViewModel({
    required String sourceId,
    required FetchSourceDetailUseCase fetchSourceDetailUseCase,
    required ManageMediaSubscriptionUseCase manageMediaSubscriptionUseCase,
    required ManageSourceEvaluationUseCase manageSourceEvaluationUseCase,
  }) : _fetchSourceDetailUseCase = fetchSourceDetailUseCase,
        _manageSourceEvaluationUseCase = manageSourceEvaluationUseCase,
      _manageMediaSubscriptionUseCase = manageMediaSubscriptionUseCase{
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

  void manageSourceEvaluation(String perspective) async {
    if(state.sourceDetail == null) return;
    await _manageSourceEvaluationUseCase.manageSourceEvaluation(
      sourceId: state.sourceDetail!.id,
      perspective: perspective,
    );
    _state = state.copyWith(
      sourceDetail: state.sourceDetail!.copyWith(
        userEvaluatedPerspective: perspective,
      ),
    );
    notifyListeners();
    showMyToast(msg: '언론 평가가 완료되었습니다.');
  }

  void manageSourceSubscriptionBySourceId() async {
    if(state.sourceDetail == null) return;
    if(state.isSubscribeLoading) return;
    _state = state.copyWith(isSubscribeLoading: true);

    if(state.sourceDetail!.isSubscribed) {
      await _manageMediaSubscriptionUseCase.unsubscribeSourceBySourceId(state.sourceDetail!.id);
      MediaSubscriptionEvents.notifyMediaUnsubscribed(state.sourceDetail!.id);
    } else {
      await _manageMediaSubscriptionUseCase.subscribeSouceBySouceId(state.sourceDetail!.id);
      MediaSubscriptionEvents.notifyMediaSubscribed(state.sourceDetail!.id);
    }

    Fluttertoast.showToast(
        msg: state.sourceDetail!.isSubscribed?
        "관심 언론에서 해제하였습니다." : "관심 언론으로 등록하였습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.gray3,
        textColor: AppColors.white,
        fontSize: 16.0
    );

    _state = state.copyWith(
      isSubscribeLoading: false,
      sourceDetail: state.sourceDetail!.copyWith(
        isSubscribed: !state.sourceDetail!.isSubscribed,
      ),
    );
    notifyListeners();
  }
}
