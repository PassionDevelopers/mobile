import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../ui/fonts.dart';

enum NotFoundType {
  issue,
  article,
  topic,
  user;

  String get name {
    switch (this) {
      case NotFoundType.issue:
        return '이슈가';
      case NotFoundType.article:
        return '기사가';
      case NotFoundType.topic:
        return '토픽이';
      case NotFoundType.user:
        return '사용자가';
    }
  }
}

class NotFound extends StatelessWidget {
  const NotFound({super.key, required this.notFoundType});
  final NotFoundType notFoundType;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 200, height: 200,
            child: Lottie.asset('assets/lottie/not_found_black.json',)),
        MyText.reg(
          '발견된 ${notFoundType.name} 없습니다.',
        ),
      ],
    );
  }
}
