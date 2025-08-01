import 'package:flutter/material.dart';

class BottomSafePadding extends StatelessWidget {
  const BottomSafePadding({super.key});

  @override
  Widget build(BuildContext context) {
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;
    return SizedBox(height: safeBottomPadding,);
  }
}

double getBottomSafePadding(BuildContext context) {
  // MediaQuery를 통해 현재 화면의 안전 영역 하단 패딩을 가져옵니다.
  return MediaQuery.of(context).padding.bottom;
}