String getTimeAgo(DateTime createdAt) {
  final now = DateTime.now();
  final koreaTime = createdAt.add(Duration(hours: 9));
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
