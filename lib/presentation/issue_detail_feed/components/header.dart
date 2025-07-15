import 'package:flutter/cupertino.dart';

import '../../../core/components/title/issue_info_title.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import '../../../ui/fonts.dart';

class IssueDetailHeader extends StatelessWidget {
  const IssueDetailHeader({super.key, required this.issue});

  final IssueDetail issue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
          child: MyText.h0(issue.title, maxLines: 3),
        ),
        IssueInfoTitle(
          mediaTotal: issue.coverageSpectrum.total,
          viewCount: issue.view,
          time: issue.updatedAt ?? issue.createdAt,
        ),
      ],
    );
  }
}
