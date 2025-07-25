import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/chips/blind_chip.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/method/text_parsing.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/presentation/issue_detail_feed/components/header.dart';
import 'package:could_be/presentation/issue_detail_feed/components/issue_detail_summary.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HotIssueView extends StatefulWidget {
  const HotIssueView({super.key, required this.hotIssues});
  final HotIssues hotIssues;
  @override
  State<HotIssueView> createState() => _HotIssueViewState();
}

class _HotIssueViewState extends State<HotIssueView> {
  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      backgroundColor: AppColors.background,
      body: Ink(
        color: AppColors.background,
        // child: Flexible(
        //   child: CardSwiper(
        //     // cardsCount: cards.length,
        //     cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
        //   ),
        // ),
      //   child: Column(
      //     children: [
      //       IssueDetailSummary(
      //         issue: issue,
      //         fontSize: state.fontSize,
      //       ),
      //       if (issue.commonSummary != null) SizedBox(height: MyPaddings.extraLarge),
      //     ],
      //   )
      )
    );
  }
}
