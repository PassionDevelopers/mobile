import 'package:could_be/presentation/notice/notice_view.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {

  void showNotice(context){
    showDialog(context: context, builder: (context) {
      return NoticeView();
    });
  }
}
