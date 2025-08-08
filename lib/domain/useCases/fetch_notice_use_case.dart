import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/domain/entities/notices.dart';
import 'package:could_be/domain/repositoryInterfaces/notice_interface.dart';

class FetchNoticeUseCase {
  final NoticeRepository _noticeRepository;

  FetchNoticeUseCase(this._noticeRepository);

  Future<Notice?> fetchPopUpNotice() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchNotices,
      parameters: {
        'type': 'popup',
      },
    );
    return await _noticeRepository.fetchPopupNotice();
  }

  Future<Notices> fetchNotices() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchNotices,
      parameters: {
        'type': 'list',
      },
    );
    return await _noticeRepository.fetchNotices();
  }

  Future<Notice> fetchNoticeById(String noticeId) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchNotices,
      parameters: {
        'type': 'detail',
        'notice_id': noticeId,
      },
    );
    return await _noticeRepository.fetchNoticeById(noticeId);
  }
}