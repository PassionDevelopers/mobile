import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../core/many_use.dart';
import '../../ui/color.dart';

class ShortsView extends StatefulWidget {
  const ShortsView({super.key});
  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  final CardSwiperController controller = CardSwiperController();

  int indexNow = 0;
  String issueId = Get.arguments;

  Widget myCard({required int index, required bool isActive}){
    return Card(
      // padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //   borderRadius: const BorderRadius.all(Radius.circular(20)),
      //   // gradient: isActive? LinearGradient(
      //   //   begin: Alignment.topCenter,
      //   //   end: Alignment.bottomCenter,
      //   //   colors: [Color(0xffFFAA50), Color(0xffD85672), Color(0xff28287A), Color(0xff285CC4)],
      //   // ) : null,
      //   color: !isActive? Color(0xff525252) : null,
      // ),
      color: isActive? AppColors.surface : AppColors.border,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //     borderRadius: const BorderRadius.all(Radius.circular(20)),
        //     color: Color(0xff23293A)
        // ),
        child: autoSizeText('이 기사는 어쩌구 저쩌구', color: Colors.black),
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction,) {
    setState(() {
      indexNow = currentIndex ?? indexNow;
    });
    return true;
  }

  bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction,) {
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      currentIndex: 0,
      body: SizedBox(),
      // body: FutureBuilder(
      //     future: GetIssue().getIssue(issueId),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.hasData) {
      //           WholeIssueModel wholeIssueModel = WholeIssueModel.fromJson(
      //               snapshot.data!);
      //           if (snapshot.data == null) {
      //             return Center(
      //               child: Text('No data found'),
      //             );
      //           }
      //           return Stack(
      //             children: [
      //               NewsApp(wholeIssueModel: wholeIssueModel,),
      //               Align(
      //                 alignment: Alignment.bottomCenter,
      //                 child: Padding(
      //                   padding: EdgeInsets.all(MyPaddings.medium),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Flexible(child: ElevatedButton(onPressed: (){
      //                       },
      //                       style: ElevatedButton.styleFrom(
      //                         backgroundColor: AppColors.primaryLight,
      //                         foregroundColor: Colors.white
      //                       ),
      //                       child: MyText.h3('원문 기사'))),
      //                       Flexible(child: ElevatedButton(onPressed: (){
      //                       }, child: MyText.h3('차이점 분석'))),
      //                       Flexible(child: ElevatedButton(onPressed: (){
      //                       }, child: MyText.h3('커뮤니티')))
      //                     ],
      //                   )
      //                 ),
      //               )
      //             ],
      //           );
      //         } else if (snapshot.hasError) {
      //           return Center(
      //             child: Text('Error: ${snapshot.error}'),
      //           );
      //         }
      //       }
      //       return LoadingView2();
      //   }
      // )
    );
  }
}

// class NewsApp extends StatefulWidget {
//   const NewsApp({super.key, required this.wholeIssueModel});
//   final WholeIssueModel wholeIssueModel;
//   @override
//   State<NewsApp> createState() => _NewsAppState();
// }
//
// class _NewsAppState extends State<NewsApp> with TickerProviderStateMixin {
//   final PageController _pageController = PageController(initialPage: 1);
//   int currentPerspective = 1; // 0: 좌파, 1: 중도, 2: 우파
//   bool showMediaLinks = false;
//   late DetailIssueModel issue = widget.wholeIssueModel.issue;
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
//   Widget myCard({required int index, required bool isActive, required String text}){
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       color: isActive? AppColors.surface : AppColors.border,
//       child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//             // color: Color(0xff23293A),
//             border: Border.all(color: AppColors.border,)
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MyText.h1(issue.title,),
//                 SizedBox(height: MyPaddings.small),
//                 MyText.reg(
//                   issue.getDate(),
//                   color: AppColors.textDate,
//                 ),
//               ],
//             ),
//             SizedBox(height: MyPaddings.medium),
//             // 언론사 분포 바
//             CardBiasBar(coverageSpectrum: issue.coverageSpectrum),
//             SizedBox(height: MyPaddings.medium),
//             Text(text),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction,) {
//     setState(() {
//       indexNow = currentIndex ?? indexNow;
//     });
//     return true;
//   }
//
//   bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction,) {
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Swiper(
//     //   itemBuilder: (BuildContext context, int index) {
//     //     return Center(child: myCard(index: index, isActive: indexNow == index,
//     //         text: index == 0? issue.leftSummary : index == 1? issue.centerSummary : issue.rightSummary));
//     //   },
//     //   itemCount: 10,
//     //   itemWidth: 300.0,
//     //   itemHeight: 400.0,
//     //   layout: SwiperLayout.STACK,
//     //   controller: ,
//     //
//     // );
//     return CardSwiper(
//         allowedSwipeDirection: AllowedSwipeDirection.only(
//           left: true, right: true
//         ),
//         controller: controller,
//         cardsCount: 3,
//         onSwipe: _onSwipe,
//         onUndo: _onUndo,
//         numberOfCardsDisplayed: 3,
//         backCardOffset: const Offset(0, 40),
//         padding: const EdgeInsets.all(10.0),
//         cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage,){
//           return Center(child: myCard(index: index, isActive: indexNow == index,
//               text: index == 0? issue.leftSummary : index == 1? issue.centerSummary : issue.rightSummary));
//         }
//     );
//   }
// }

