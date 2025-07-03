import 'package:flutter/material.dart';

class MyPopScope extends StatelessWidget {
  const MyPopScope({super.key, required this.callBack, required this.child});
  final Widget child;
  final VoidCallback callBack;
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (!didPop) {
            return callBack();
          }
        },
        child: child);
  }
}
