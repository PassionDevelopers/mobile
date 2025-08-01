import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/domain/entities/notices.dart';
import 'package:could_be/domain/repositoryInterfaces/notice_interface.dart';

class FetchNoticeUseCase {
  final NoticeRepository _noticeRepository;

  FetchNoticeUseCase(this._noticeRepository);

  Future<Notice?> fetchPopUpNotice() async {
    return await _noticeRepository.fetchPopupNotice();
  }

  Future<Notices> fetchNotices() async {
    return await _noticeRepository.fetchNotices();
  }

  Future<Notice> fetchNoticeById(String noticeId) async {
    return await _noticeRepository.fetchNoticeById(noticeId);
  }
}