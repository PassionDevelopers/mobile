
import 'package:flutter/material.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';
import '../../method/date_time_parsing.dart';

class IssueInfoTitle extends StatelessWidget {
  const IssueInfoTitle({super.key, required this.mediaTotal, required this.viewCount, required this.time, this.isRead});
  final int mediaTotal;
  final int viewCount;
  final DateTime time;
  final bool? isRead;

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
      '$mediaTotal개 언론 · 조회수 ${refineViewCount(viewCount)} · ${getTimeAgo(time)}${isRead ?? false? '· 읽음' : ''}',
      color: AppColors.gray2,
    );
  }
}
