import 'package:could_be/domain/useCases/fetch_notice_use_case.dart';
import 'package:could_be/presentation/notice/notice_state.dart';
import 'package:flutter/material.dart';

class NoticeViewModel with ChangeNotifier {

  final FetchNoticeUseCase _fetchNoticeUseCase;
  NoticeViewModel(this._fetchNoticeUseCase);

  NoticeState state = NoticeState();
  NoticeState get _state => state;

  Future<void> fetchNotices() async {
    state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final notices = await _fetchNoticeUseCase.fetchNotices();
      state = state.copyWith(notices: notices, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
    notifyListeners();
  }
}
