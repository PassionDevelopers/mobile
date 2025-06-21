import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/presentation/shorts/shorts_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../domain/entities/whole_issue.dart';

class ShortsView extends StatefulWidget {
  const ShortsView({super.key, required this.wholeIssue});

  final WholeIssue wholeIssue;

  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  final CardSwiperController controller = CardSwiperController();
  late final IssueDetail issue = widget.wholeIssue.issue;
  int indexNow = 0;
  Bias currentBias = Bias.center; // 0: 좌파, 1: 중도, 2: 우파

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        ShortsComponent(issue: issue),
        ShortsComponent(issue: issue),
        ShortsComponent(issue: issue),
      ]
    );
  }
}


// class NewsApp extends StatefulWidget {
//   const NewsApp({super.key, required this.wholeIssue});
//
//   final WholeIssue wholeIssue;
//
//   @override
//   State<NewsApp> createState() => _NewsAppState();
// }
//
// class _NewsAppState extends State<NewsApp> with TickerProviderStateMixin {
//   final PageController _pageController = PageController(initialPage: 1);
//   Bias currentBias = Bias.center;// 0: 좌파, 1: 중도, 2: 우파
//   bool showMediaLinks = false;
//   late IssueDetail issue = widget.wholeIssue.issue;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   final CardSwiperController controller = CardSwiperController();
//   int indexNow = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

// return Swiper(
//   itemBuilder: (BuildContext context, int index) {
//     return Center(child: myCard(index: index, isActive: indexNow == index,
//         text: index == 0? issue.leftSummary : index == 1? issue.centerSummary : issue.rightSummary));
//   },
//   itemCount: 10,
//   itemWidth: 300.0,
//   itemHeight: 400.0,
//   layout: SwiperLayout.STACK,
//   controller: ,
//
// );
// return CardSwiper(
//     allowedSwipeDirection: AllowedSwipeDirection.only(
//       left: true, right: true
//     ),
//     controller: controller,
//     cardsCount: 3,
//     onSwipe: _onSwipe,
//     onUndo: _onUndo,
//     numberOfCardsDisplayed: 3,
//     backCardOffset: const Offset(0, 40),
//     padding: const EdgeInsets.all(10.0),
//     cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage,){
//       return Center(child: myCard(index: index, isActive: indexNow == index,
//           text: index == 0? issue.leftSummary : index == 1? issue.centerSummary : issue.rightSummary));
//     }
// );

// Widget myCard({required int index, required bool isActive}) {
//   return Card(
//     // padding: EdgeInsets.all(5),
//     // decoration: BoxDecoration(
//     //   borderRadius: const BorderRadius.all(Radius.circular(20)),
//     //   // gradient: isActive? LinearGradient(
//     //   //   begin: Alignment.topCenter,
//     //   //   end: Alignment.bottomCenter,
//     //   //   colors: [Color(0xffFFAA50), Color(0xffD85672), Color(0xff28287A), Color(0xff285CC4)],
//     //   // ) : null,
//     //   color: !isActive? Color(0xff525252) : null,
//     // ),
//     color: isActive ? AppColors.surface : AppColors.border,
//     child: Container(
//       height: double.infinity,
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       // decoration: BoxDecoration(
//       //     borderRadius: const BorderRadius.all(Radius.circular(20)),
//       //     color: Color(0xff23293A)
//       // ),
//       child: autoSizeText('이 기사는 어쩌구 저쩌구', color: Colors.black),
//     ),
//   );
// }
//
// bool _onSwipe(
//   int previousIndex,
//   int? currentIndex,
//   CardSwiperDirection direction,
// ) {
//   setState(() {
//     indexNow = currentIndex ?? indexNow;
//   });
//   return true;
// }
//
// bool _onUndo(
//   int? previousIndex,
//   int currentIndex,
//   CardSwiperDirection direction,
// ) {
//   return true;
// }
