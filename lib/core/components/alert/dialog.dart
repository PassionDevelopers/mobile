import 'package:flutter/material.dart';

void showAlert({required String msg, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('알림'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}

void showConfirm({
  required BuildContext context,
  required String msg,
  required Function callback,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('알림'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}