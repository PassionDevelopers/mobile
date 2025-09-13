import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/text/interactive_text.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_box.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_title.dart';
import 'package:flutter/material.dart';
import '../../../core/components/bias/bias_bar.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue/issue_detail.dart';
import 'background_description.dart' show BackgroundDescription;
import 'header.dart';

class IssueDetailSummary extends StatefulWidget {
  const IssueDetailSummary({
    super.key,
    required this.issue,
    required this.fontSize,
    required this.isSpread,
    required this.spreadCallback,
  });

  final IssueDetail issue;
  final double fontSize;
  final bool isSpread;
  final VoidCallback spreadCallback;

  @override
  State<IssueDetailSummary> createState() => _IssueDetailSummaryState();
}

class _IssueDetailSummaryState extends State<IssueDetailSummary> {

  @override
  Widget build(BuildContext context) {
    return SectorBox(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectorTitle(title: '이슈 개요',
              icon: Icons.article_outlined,
              onTap: widget.spreadCallback,
              isSpread: widget.isSpread),
          if(widget.isSpread)SizedBox(height: MyPaddings.medium),
          if(widget.isSpread)parseAiText(
              widget.issue.summary, widget.fontSize,
              AppColors.gray700, Colors.amberAccent),
        ],
      ),
    );
  }
}
