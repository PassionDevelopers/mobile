import 'dart:developer';

import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/domain/useCases/fetch_notice_use_case.dart';
import 'package:could_be/presentation/notice/notice_dialog/notice_dialog_state.dart';
import 'package:flutter/material.dart';

class NoticeDialogViewModel with ChangeNotifier {

  final FetchNoticeUseCase _fetchNoticeUseCase;
  NoticeDialogViewModel({
    required FetchNoticeUseCase fetchNoticeUseCase,
    required Notice notice,
  }) : _fetchNoticeUseCase = fetchNoticeUseCase{
    if(notice.content == null){
      fetchNoticeById(notice.id);
    } else {
      state = state.copyWith(notice: notice);
    }
  }

  NoticeDialogState state = NoticeDialogState();
  NoticeDialogState get _state => state;

  Future<void> fetchNoticeById(String noticeId) async {
    state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final notice = await _fetchNoticeUseCase.fetchNoticeById(noticeId);
      state = state.copyWith(notice: notice, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to fetch notice by ID: $e');
    }
    notifyListeners();
  }


}