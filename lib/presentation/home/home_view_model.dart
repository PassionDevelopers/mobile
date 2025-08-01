import 'dart:developer';
import 'package:could_be/domain/useCases/fetch_notice_use_case.dart';
import 'package:flutter/material.dart';
import '../notice/notice_dialog/notice_dialog.dart';

class HomeViewModel with ChangeNotifier {

  FetchNoticeUseCase fetchNoticeUseCase;

  HomeViewModel({
    required this.fetchNoticeUseCase,
  });

  void showNotice(context)async{
    await fetchNoticeUseCase.fetchPopUpNotice().then((notice) {
      if (notice == null) {
        return;
      }
      showDialog(context: context, builder: (context) {
        return NoticeDialog(notice: notice,);
      });
    }).catchError((error) {
      // Handle error if needed
      log('Error fetching notice: $error');
    });

  }
}
