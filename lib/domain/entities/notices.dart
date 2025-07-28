import 'package:could_be/domain/entities/notice.dart';

class Notices{

  final List<Notice> notices;
  final bool hasMore;
  final String? lastNoticeId;

  Notices({
    required this.notices,
    required this.hasMore,
    required this.lastNoticeId,
  });
}