import 'package:could_be/domain/entities/notice.dart';

class NoticeDialogState{
  Notice? notice;
  bool isLoading;

  NoticeDialogState({
    this.notice,
    this.isLoading = false,
  });

  NoticeDialogState copyWith({
    Notice? notice,
    bool? isLoading,
  }) {
    return NoticeDialogState(
      notice: notice ?? this.notice,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}