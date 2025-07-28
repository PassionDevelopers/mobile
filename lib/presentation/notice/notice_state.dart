import 'package:could_be/domain/entities/notices.dart';

class NoticeState{
  Notices? notices;
  bool isLoading;

  NoticeState({
    this.notices,
    this.isLoading = false,
  });

  NoticeState copyWith({
    Notices? notices,
    bool? isLoading,
  }) {
    return NoticeState(
      notices: notices ?? this.notices,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}