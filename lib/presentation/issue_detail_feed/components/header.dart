import 'package:flutter/cupertino.dart';

import '../../../core/components/title/issue_info_title.dart';

class IssueDetailHeader extends StatelessWidget {
  const IssueDetailHeader({super.key, required this.mediaTotal, required this.viewCount, required this.time});

  final int mediaTotal;
  final int viewCount;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return IssueInfoTitle(
      mediaTotal: mediaTotal,
      viewCount: viewCount,
      time: time,
    );
  }
}
