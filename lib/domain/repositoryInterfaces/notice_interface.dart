import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/domain/entities/notices.dart';

abstract class NoticeRepository{
  Future<Notices> fetchNotices({String? lastNoticeId});

  Future<Notice> fetchPopupNotice({String? lastNoticeId});

  Future<Notice> fetchNoticeById(String noticeId);
}