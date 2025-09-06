
int getWeekOfMonth(DateTime date) {
  // 이번 달 1일
  final firstDayOfMonth = DateTime(date.year, date.month, 1);

  // 1일의 요일 (1: 월요일, 7: 일요일)
  final firstWeekday = firstDayOfMonth.weekday;

  // 날짜와 요일을 고려한 오프셋 일 수
  final offset = date.day + (firstWeekday - 1);

  // 주차 계산 (ceil로 올림 처리)
  return (offset / 7).ceil();
}

DateTime _getKoreaTime(DateTime dateTime) {
  return dateTime.add(Duration(hours: 9));
}

String formatDateTimeToMinute(DateTime dateTime) {
  final koreaTime = _getKoreaTime(dateTime);
  final String formattedDate = '${koreaTime.month}월 ${koreaTime.day}일 ${koreaTime.hour}:${koreaTime.minute.toString().padLeft(2, '0')}';
  return formattedDate;
}

String formatDateTimeToDay(DateTime dateTime) {
  final koreaTime = _getKoreaTime(dateTime);
  final String formattedDate = '${koreaTime.month}월 ${koreaTime.day}일';
  return formattedDate;
}

String getTimeAgo(DateTime createdAt) {
  final now = DateTime.now();
  final koreaTime = _getKoreaTime(createdAt);
  final difference = now.difference(koreaTime);

  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()}년 전';
  } else if (difference.inDays > 30) {
    return '${(difference.inDays / 30).floor()}달 전';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}일 전';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}시간 전';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금 전';
  }
}
