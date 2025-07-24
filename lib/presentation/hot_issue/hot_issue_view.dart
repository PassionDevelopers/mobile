// import 'package:could_be/core/components/bias/bias_bar.dart';
// import 'package:could_be/core/components/chips/blind_chip.dart';
// import 'package:could_be/core/components/image/image_container.dart';
// import 'package:could_be/core/components/layouts/scaffold_layout.dart';
// import 'package:could_be/core/method/text_parsing.dart';
// import 'package:could_be/core/themes/margins_paddings.dart';
// import 'package:could_be/domain/entities/issue_detail.dart';
// import 'package:could_be/presentation/issue_detail_feed/components/header.dart';
// import 'package:could_be/ui/color.dart';
// import 'package:could_be/ui/fonts.dart';
// import 'package:flutter/material.dart';
//
// class HotIssueView extends StatefulWidget {
//   const HotIssueView({super.key, required this.issue});
//   final IssueDetail issue;
//   @override
//   State<HotIssueView> createState() => _HotIssueViewState();
// }
//
// class _HotIssueViewState extends State<HotIssueView> {
//   @override
//   Widget build(BuildContext context) {
//     return RegScaffold(
//       backgroundColor: AppColors.background,
//       body: Ink(
//         color: AppColors.background,
//         child: ListenableBuilder(
//           listenable: viewModel,
//           builder: (context, _) {
//             final state = viewModel.state;
//             if (state.isLoading) {
//               return IssueDetailLoadingView();
//             } else {
//               if (state.issueDetail == null) {
//                 return Center(child: Text('발견된 이슈가 없습니다.'));
//               } else {
//                 final issue = state.issueDetail!;
//                 return Stack(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             controller: controller,
//                             child: Column(
//                               children: [
//                                 IssueDetailSummary(
//                                   issue: issue,
//                                   fontSize: state.fontSize,
//                                 ),
//                                 if (issue.commonSummary != null) SizedBox(height: MyPaddings.extraLarge),
//
//                                 if (issue.commonSummary != null)
//                                   IssueDetailCommonSummary(
//                                     commonSummary: issue.commonSummary!,
//                                     fontSize: state.fontSize,
//                                   ),
//                                 if (issue.leftComparison != null ||
//                                     issue.centerComparison != null ||
//                                     issue.rightComparison != null)
//                                   SizedBox(height: MyPaddings.large),
//
//                                 if (issue.leftComparison != null ||
//                                     issue.centerComparison != null ||
//                                     issue.rightComparison != null)
//                                   ListenableBuilder(
//                                     listenable: ValueNotifier(
//                                       state.isEvaluating,
//                                     ),
//                                     builder: (context, listenable) {
//                                       return IssueDetailBiasComparison(
//                                         fontSize: state.fontSize,
//                                         moveToNextPage: () {
//                                           moveToNextPage(
//                                             issue.commonSummary != null
//                                                 ? 4
//                                                 : 3,
//                                           );
//                                         },
//                                         existCenter: issue.centerComparison != null,
//                                         existLeft: issue.leftComparison != null,
//                                         existRight: issue.rightComparison != null,
//                                         isEvaluating: state.isEvaluating,
//                                         onBiasSelected:
//                                         viewModel
//                                             .manageIssueEvaluation,
//                                         leftLikeCount:
//                                         issue.leftLikeCount,
//                                         centerLikeCount:
//                                         issue.centerLikeCount,
//                                         rightLikeCount:
//                                         issue.rightLikeCount,
//                                         userEvaluation:
//                                         issue.userEvaluation,
//                                         leftComparison: issue.leftComparison,
//                                         centerComparison:
//                                         issue.centerComparison,
//                                         rightComparison:
//                                         issue.rightComparison,
//                                       );
//                                     },
//                                   ),
//
//                                 SizedBox(height: MyPaddings.extraLarge),
//                                 IssueDetailTabs(
//                                   fontSize: state.fontSize,
//                                   issue: issue,
//                                   moveToNextPage: () {
//                                     moveToNextPage(
//                                       issue.commonSummary != null ? 3 : 2,
//                                     );
//                                   },
//                                   postDasiScore: viewModel.postDasiScore,
//                                 ),
//
//                                 SizedBox(height: MyPaddings.extraLarge),
//
//                                 SourceListPage(
//                                   articlesGBBAS:
//                                   issue.articles
//                                       .toGroupByBiasAndSource(),
//                                   hasNextIssue:
//                                   issue.nextIssueIds.isNotEmpty,
//                                   toNextIssue: () {
//                                     viewModel.fetchIssueDetailById(
//                                       issue.nextIssueIds.first,
//                                     );
//                                   },
//                                 ),
//                                 SizedBox(height: MyPaddings.extraLarge),
//                                 // Padding(
//                                 //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
//                                 //   child: CustomReportPage(),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // if (!ResponsiveUtils.isDesktop(context))
//                         //   SmoothPageIndicator(
//                         //     controller: controller,
//                         //     count: state.pageCount,
//                         //     axisDirection: Axis.vertical,
//                         //     onDotClicked: (index) {
//                         //       controller.animateToPage(
//                         //         index,
//                         //         duration: const Duration(milliseconds: 300),
//                         //         curve: Curves.easeInOut,
//                         //       );
//                         //     },
//                         //     effect: SlideEffect(
//                         //       spacing: 0,
//                         //       radius: 0,
//                         //       dotWidth: safeAreaHeight / state.pageCount,
//                         //       dotHeight: 5,
//                         //       paintStyle: PaintingStyle.stroke,
//                         //       strokeWidth: 1.5,
//                         //       dotColor: Colors.grey,
//                         //       activeDotColor: AppColors.primary,
//                         //       type: SlideType.slideUnder,
//                         //     ),
//                         //   ),
//                       ],
//                     ),
//                     Positioned(
//                       bottom: 32,
//                       right: 0,
//                       child: AnimatedScale(
//                         duration: Duration(milliseconds: 200),
//                         scale: 1.0,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             // floatingButton(
//                             //   onPressed: () {
//                             //     viewModel.setFontSize();
//                             //   },
//                             //   icon:
//                             //       viewModel.state.fontSize == 18
//                             //           ? Icons.format_size_outlined
//                             //           : Icons.format_size,
//                             // ),
//                             floatingButton(
//                               onPressed: viewModel.manageIssueSubscription,
//                               icon:
//                               viewModel.state.issueDetail!.isSubscribed
//                                   ? Icons.bookmark
//                                   : Icons.bookmark_add_outlined,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
