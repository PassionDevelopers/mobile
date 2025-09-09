import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../themes/fonts.dart';

enum NotFoundType {
  issue,
  article,
  topic,
  source,
  user,
  majorComment,
  comment,
  notice;

  String get name {
    switch (this) {
      case NotFoundType.comment:
        return '등록된 댓글이';
      case NotFoundType.majorComment:
        return '등록된 대표 의견이';
      case NotFoundType.issue:
        return '발견된 이슈가';
      case NotFoundType.article:
        return '발견된 기사가';
      case NotFoundType.topic:
        return '발견된 토픽이';
      case NotFoundType.source:
        return '평가한 언론이';
      case NotFoundType.user:
        return '발견된 사용자가';
      case NotFoundType.notice:
        return '등록된 공지사항이';
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
          '${notFoundType.name} 없습니다.',
        ),
      ],
    );
  }
}
