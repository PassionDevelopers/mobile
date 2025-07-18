
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