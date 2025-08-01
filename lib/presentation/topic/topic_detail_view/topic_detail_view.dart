import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/presentation/topic/topic_detail_view/topic_detail_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/components/cards/issue_card.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/components/title/big_title.dart';
import '../../../core/di/di_setup.dart';
import '../../../core/many_use.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../ui/fonts.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/components/layouts/responsive_grid.dart';

class TopicDetailView extends StatelessWidget {
  const TopicDetailView({super.key, required this.topicId});
  final String topicId;

  final Color primary = const Color(0xff0A0A0B);
  final Color primaryLight = Colors.white;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<TopicDetailViewModel>(param1: topicId);
    return RegScaffold(
      isScrollPage: true,
      backgroundColor: primaryLight,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, state) {
          final state = viewModel.state;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state.topicDetail == null) {
              return Center(child: Text('발견된 토픽이 없습니다.'));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: primaryLight,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: primary),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      '토픽 상세 정보',
                      style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    centerTitle: false,
                  ),
                  const SizedBox(height: MyPaddings.medium),
                  // 토픽 정보
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.h1(state.topicDetail!.name),
                        const SizedBox(height: 8),
                        MyText.reg('카테고리: ${state.topicDetail!.category}'),
                        const SizedBox(height: 8),
                        MyText.reg('구독자 ${state.topicDetail!.subscribersCount}명'),
                        const SizedBox(height: 8),
                        MyText.reg('총 이슈 수: ${state.topicDetail!.totalIssuesCount}개'),
                        const SizedBox(height: 16),
                        MyText.reg(state.topicDetail!.description, maxLines: 3),
                      ],
                    ),
                  ),

                  const SizedBox(height: MyPaddings.medium),

                  // 구독 버튼
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: state.topicDetail!.isSubscribed
                            ? const Color(0xFFE8E8E8)
                            : primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        state.topicDetail!.isSubscribed ? '구독 중' : '구독하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: state.topicDetail!.isSubscribed
                              ? primary
                              : primaryLight,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: MyPaddings.medium),

                  Padding(
                    padding: EdgeInsets.only(left: MyPaddings.largeMedium),
                    child: BigTitle(title: '최근 이슈'),
                  ),

                  state.topicDetail!.recentIssues.issues.isEmpty
                      ? Center(child: Text('발견된 이슈가 없습니다.'))
                      : ResponsiveBuilder(
                          builder: (context, deviceType) {
                            if (ResponsiveUtils.isMobile(context)) {
                              return Column(
                                children: [
                                  for (int i = 0; i < state.topicDetail!.recentIssues.issues.length; i++)
                                    IssueCard(issue: state.topicDetail!.recentIssues.issues[i], isDailyIssue: false),
                                ],
                              );
                            }

                            return ResponsiveGrid(
                              children: state.topicDetail!.recentIssues.issues
                                  .map((issue) => IssueCard(issue: issue, isDailyIssue: false))
                                  .toList(),
                            );
                          },
                        ),
                  BottomSafePadding()
                ],
              ),
            );
          }
        }
      ),
    );
  }
}

// class TopicDetailView extends StatelessWidget {
//   const TopicDetailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     // return MyScaffold(
//     //   showAppBar: false,
//     //   showBottomBar: false,
//     //   body: CustomScrollView(
//     //     slivers: <Widget>[
//     //       SliverAppBar(
//     //           iconTheme: IconThemeData(color: Colors.black),
//     //           elevation: 0,
//     //           pinned: true,
//     //           leading: IconButton(
//     //               onPressed:(){
//     //               },
//     //               icon: const Icon(Icons.arrow_back)
//     //           ),
//     //           expandedHeight: MediaQuery.of(context).size.width * (10/25)
//     //               + (MyPaddings.large * 8) + AppBar().preferredSize.height,
//     //           flexibleSpace:FlexibleSpaceBar(
//     //             centerTitle: true,
//     //             background: Padding(
//     //               padding: EdgeInsets.symmetric(horizontal : MyPaddings.large),
//     //               child: Column(children: [
//     //                 SizedBox(height: AppBar().preferredSize.height,),
//     //                 // Material(child: Hero(tag: title, child: TopicCard(title: title, isBack: true,))),
//     //                 SizedBox(height: MyPaddings.large),
//     //                 SizedBox(height: MyPaddings.large*2,
//     //                   child: Align(alignment: Alignment.centerLeft, child: MyText.h2('관련 키워드')),
//     //                 ),
//     //                 SizedBox(height: MyPaddings.large),
//     //                 SizedBox(height: MyPaddings.large*3, child: Row(
//     //                   children: [
//     //                     _buildKeywordButton('관련 키워드 1', 0, true),
//     //                     SizedBox(width: 8),
//     //                     _buildKeywordButton('관련 키워드 2', 1, false),
//     //                     SizedBox(width: 8),
//     //                     _buildKeywordButton('더보기', 2, false),
//     //                   ],
//     //                 ),),
//     //                 SizedBox(height: MyPaddings.large),
//     //               ]),
//     //             ),
//     //           )
//     //       ),
//     //       // FutureBuilder<Map<String, dynamic>?>(
//     //       //   future: GetIssues().getIssues(),
//     //       //   builder: (context, snapshot) {
//     //       //       if (snapshot.connectionState == ConnectionState.done) {
//     //       //         if(snapshot.hasData && snapshot.data != null) {
//     //       //           IssuesModel issuesModel = IssuesModel.fromJson(snapshot.data!);
//     //       //           return SliverList(
//     //       //             delegate: SliverChildBuilderDelegate((context, i) {
//     //       //               return NewsCard(
//     //       //                 issueModel: issuesModel.issues[i],
//     //       //                 isDailyIssue: false,
//     //       //
//     //       //               );
//     //       //             },
//     //       //             childCount: issuesModel.issues.length),
//     //       //           );
//     //       //         } else if (snapshot.hasData && snapshot.data == null) {
//     //       //           return SliverToBoxAdapter(
//     //       //             child: Center(
//     //       //               child: Text('No data available'),
//     //       //             ),
//     //       //           );
//     //       //         } else {
//     //       //           return SliverToBoxAdapter(
//     //       //             child: Center(
//     //       //               child: Text('No issues found'),
//     //       //             ),
//     //       //           );
//     //       //         }
//     //       //       } else if (snapshot.hasError) {
//     //       //         return SliverToBoxAdapter(
//     //       //           child: Center(
//     //       //             child: Text('Error: ${snapshot.error}'),
//     //       //           ),
//     //       //         );
//     //       //       }
//     //       //       return SliverToBoxAdapter(child: LoadingView());
//     //       //     }
//     //       // ),
//     //     ],
//     //   )
//     // );
//   }
// }
