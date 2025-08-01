import 'package:card_swiper/card_swiper.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/presentation/hot_issue/hot_issue_last_page_card.dart';
import 'package:could_be/presentation/hot_issue/hot_issue_page_card.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class HotIssueView extends StatefulWidget {
  const HotIssueView({super.key, required this.hotIssues});
  final HotIssues hotIssues;
  @override
  State<HotIssueView> createState() => _HotIssueViewState();
}

class _HotIssueViewState extends State<HotIssueView> {
  late List<Widget> cards;
  final SwiperController controller = SwiperController();

  @override
  void initState() {
    super.initState();
    cards = [
      for (final issue in widget.hotIssues.issues)
        HotIssuePageCard(issue: issue),
    ];
    cards.add(
      HotIssueLastPageCard(issueCount: widget.hotIssues.issues.length)
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: false,
      appBarTitle: '${formatDateTimeToDay(widget.hotIssues.hotTime)} 주요 이슈 모음',
      backgroundColor: AppColors.background,
      body: Ink(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: cards.isEmpty? Center(child: NotFound(notFoundType: NotFoundType.issue)) :
                Swiper(itemBuilder: (BuildContext context, int index) {
                    return cards[index];
                  },
                  controller: controller,
                  loop: false,
                  itemCount: cards.length,
                  viewportFraction: 0.85,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: AppColors.gray4,
                      activeColor: AppColors.primary,
                      size: 8.0,
                      activeSize: 10.0,
                    )
                  ),
                  scale: 0.9,
                  control: SwiperControl(color: AppColors.gray3, size: 20, disableColor: Colors.transparent),
                  // containerHeight: 100,
                  // itemHeight: 100,
                )
              //   CardSwiper(
              //     numberOfCardsDisplayed: 1,
              //   cardsCount: cards.length,
              //   cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
              // ),
            ),

            // Expanded(
            //   child: Swiper(
            //     itemBuilder: (context, index) {
            //       return cards[index];
            //     },
            //     autoplay: true,
            //     itemCount: cards.length,
            //     pagination: SwiperPagination(
            //         margin: EdgeInsets.zero,
            //         builder: SwiperCustomPagination(builder: (context, config) {
            //           return ConstrainedBox(
            //             child: Container(
            //               color: Colors.white,
            //               child: Text(
            //                 '${[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
            //                 style: const TextStyle(fontSize: 20.0),
            //               ),
            //             ),
            //             constraints: const BoxConstraints.expand(height: 50.0),
            //           );
            //         })),
            //     control: const SwiperControl(),
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}
