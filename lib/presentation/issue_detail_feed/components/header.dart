import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/coverage_spectrum.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:could_be/domain/entities/issue/issue_detail.dart';
import 'package:could_be/domain/entities/issue/issue_tag.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_box.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/components/title/issue_info_title.dart';

class IssueDetailHeader extends StatelessWidget {
  const IssueDetailHeader({
    super.key,
    required this.tags,
    required this.mediaTotal,
    required this.viewCount,
    required this.time,
    required this.title,
    required this.coverageSpectrum,
  });

  final List<IssueTag> tags;
  final int mediaTotal;
  final int viewCount;
  final DateTime time;
  final String title;
  final CoverageSpectrum coverageSpectrum;

  @override
  Widget build(BuildContext context) {
    return SectorBox(content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MyPaddings.large),
        MyText.h2(title, maxLines: 2),
        SizedBox(height: MyPaddings.large),
        if (tags.isNotEmpty)
          SizedBox(
            height: 24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: tags.length,
              itemBuilder: (_, index) {
                return BlindChip(topPadding: 0, tag: tags[index]);
              },
            ),
          ),
        SizedBox(height: MyPaddings.large),
        IssueInfoTitle(
          mediaTotal: mediaTotal,
          viewCount: viewCount,
          time: time,
        ),
        SizedBox(height: MyPaddings.large),
        CardBiasBar(coverageSpectrum: coverageSpectrum, isDailyIssue: true),
      ],
    ));
  }
}
