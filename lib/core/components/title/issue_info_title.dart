

import 'package:flutter/material.dart';

import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class IssueInfoTitle extends StatelessWidget {
  const IssueInfoTitle({super.key, required this.mediaTotal, required this.viewCount, required this.time, });
  final int mediaTotal;
  final int viewCount;
  final DateTime time;

  String getTimeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

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

  String refineViewCount(int viewCount) {
    if (viewCount >= 10000) {
      if((viewCount%10000 < 1000)){
        return '${(viewCount / 10000).toStringAsFixed(0)}만회';
      }else{
        return '${(viewCount / 10000).toStringAsFixed(1)}만회';
      }
    } else if (viewCount >= 1000) {
      if((viewCount%1000 < 100)){
        return '${(viewCount / 1000).toStringAsFixed(0)}천회';
      }else{
        return '${(viewCount / 1000).toStringAsFixed(1)}천회';
      }
    } else {
      return viewCount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyText.reg(
      '${mediaTotal}개 매체 · 조회수 ${refineViewCount(viewCount)} · ${getTimeAgo(time)}',
      color: AppColors.gray2,
    );
  }
}
