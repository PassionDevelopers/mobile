
import 'package:flutter/material.dart';

class DailyIssueView extends StatefulWidget{
  const DailyIssueView({super.key});

  @override
  State<DailyIssueView> createState() => _DailyIssueViewState();
}

class _DailyIssueViewState extends State<DailyIssueView> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);
  late final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<String> issueCategories = [
    '데일리 이슈', '추천 이슈', '진보 사각지대', '보수 사각지대'
  ];
  late List<bool> issueActive = List.generate(issueCategories.length, (index) => index == 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FutureBuilder<Map<String, dynamic>?>(
        //     future: GetIssues().hot(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         if(snapshot.hasData && snapshot.data != null) {
        //           IssuesModel issuesModel = IssuesModel.fromJson(snapshot.data!);
        //           return Column(
        //             children: [
        //               Material(
        //                 color: AppColors.background,
        //                 child: Container(
        //                   height: 50,
        //                   padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
        //                   child: StatefulBuilder(
        //                       builder: (context, setChipState) {
        //                         return ListView.builder(
        //                             scrollDirection: Axis.horizontal,
        //                             controller: scrollController,
        //                             padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
        //                             itemCount: issueCategories.length,
        //                             itemBuilder: (context, index) {
        //                               return IssueChip(
        //                                   title: issueCategories[index],
        //                                   isActive: issueActive[index],
        //                                   onTap: () {
        //                                     setChipState(() {
        //                                       for (int i = 0; i < issueActive.length; i++) {
        //                                         issueActive[i] = i == index;
        //                                       }
        //                                     });
        //                                   }
        //                               );
        //                             }
        //                         );
        //                       }
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 child: CustomScrollView(
        //                   slivers: <Widget>[
        //                     SliverToBoxAdapter(
        //                         child: SizedBox(
        //                           height: MediaQuery.of(context).size.height * 0.5,
        //                           child: Column(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.small),
        //                                 child: Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Text('${DateTime.now().month}월 ${DateTime.now().day}일 주요 이슈', style: MyFontStyle.h1)
        //                                 ),
        //                               ),
        //                               Expanded(
        //                                 child: TabBarView(
        //                                   controller: tabController,
        //                                   children: [
        //                                     DailyIssueFeed(), DailyIssueFeed(), DailyIssueFeed(),
        //                                   ],
        //                                 ),
        //                               ),
        //                               TabPageSelector(
        //                                 controller: tabController,
        //                                 color: AppColors.unselected,
        //                                 selectedColor: AppColors.primary,
        //                                 borderStyle: BorderStyle.none,
        //                               ),
        //                             ],
        //                           ),
        //                         )
        //                     ),
        //                     SliverToBoxAdapter(child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.small),
        //                       child: Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: Text('데일리 이슈', style: MyFontStyle.h1)
        //                       ),
        //                     ),),
        //                     SliverList(
        //                       delegate: SliverChildBuilderDelegate((context, i) {
        //                         return NewsCard(
        //                           issueModel: issuesModel.issues[i],
        //                           isDailyIssue: false,
        //                         );
        //                       }, childCount: issuesModel.issues.length),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           );
        //         } else if (snapshot.hasData && snapshot.data == null) {
        //           return Center(
        //             child: Text('No data available'),
        //           );
        //         } else {
        //           return Center(
        //             child: Text('No issues found'),
        //           );
        //         }
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('Error: ${snapshot.error}'),
        //         );
        //       }
        //       return LoadingView();
        //     }
        // ),
        // FutureBuilder<Map<String, dynamic>?>(
        //     future: IssueViewModel().hotIssues(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         if(snapshot.hasData && snapshot.data != null) {
        //           IssueDTO issueDTO = IssueDTO.fromJson(snapshot.data!);
        //           return Column(
        //             children: [
        //               Material(
        //                 color: AppColors.background,
        //                 child: Container(
        //                   height: 50,
        //                   padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
        //                   child: StatefulBuilder(
        //                       builder: (context, setChipState) {
        //                         return ListView.builder(
        //                             scrollDirection: Axis.horizontal,
        //                             controller: scrollController,
        //                             padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
        //                             itemCount: issueCategories.length,
        //                             itemBuilder: (context, index) {
        //                               return IssueChip(
        //                                   title: issueCategories[index],
        //                                   isActive: issueActive[index],
        //                                   onTap: () {
        //                                     setChipState(() {
        //                                       for (int i = 0; i < issueActive.length; i++) {
        //                                         issueActive[i] = i == index;
        //                                       }
        //                                     });
        //                                   }
        //                               );
        //                             }
        //                         );
        //                       }
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 child: CustomScrollView(
        //                   slivers: <Widget>[
        //                     SliverToBoxAdapter(
        //                         child: SizedBox(
        //                           height: MediaQuery.of(context).size.height * 0.5,
        //                           child: Column(
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.small),
        //                                 child: Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Text('${DateTime.now().month}월 ${DateTime.now().day}일 주요 이슈', style: MyFontStyle.h1)
        //                                 ),
        //                               ),
        //                               Expanded(
        //                                 child: TabBarView(
        //                                   controller: tabController,
        //                                   children: [
        //                                     DailyIssueFeed(), DailyIssueFeed(), DailyIssueFeed(),
        //                                   ],
        //                                 ),
        //                               ),
        //                               TabPageSelector(
        //                                 controller: tabController,
        //                                 color: AppColors.unselected,
        //                                 selectedColor: AppColors.primary,
        //                                 borderStyle: BorderStyle.none,
        //                               ),
        //                             ],
        //                           ),
        //                         )
        //                     ),
        //                     SliverToBoxAdapter(child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.small),
        //                       child: Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: Text('데일리 이슈', style: MyFontStyle.h1)
        //                       ),
        //                     ),),
        //                     SliverList(
        //                       delegate: SliverChildBuilderDelegate((context, i) {
        //                         return NewsCard(
        //                           issueModel: issuesModel.issues[i],
        //                           isDailyIssue: false,
        //                         );
        //                       }, childCount: issuesModel.issues.length),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           );
        //         } else if (snapshot.hasData && snapshot.data == null) {
        //           return Center(
        //             child: Text('No data available'),
        //           );
        //         } else {
        //           return Center(
        //             child: Text('No issues found'),
        //           );
        //         }
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('Error: ${snapshot.error}'),
        //         );
        //       }
        //       return LoadingView();
        //     }
        // )
      ],
    );
  }
}
