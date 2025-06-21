import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import 'topic_components.dart';
import '../../core/many_use.dart';
import '../../core/themes/margins_paddings.dart';
import '../../ui/fonts.dart';

class TopicDetailView extends StatelessWidget {
  TopicDetailView({super.key});
  final String title = Get.arguments;
  @override
  Widget build(BuildContext context) {
    Widget _buildKeywordButton(String text, int index, bool isSelected) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4A90E2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: autoSizeText(
          text,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
        ),
      );
    }
    return MyScaffold(
      showAppBar: false,
      showBottomBar: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              pinned: true,
              leading: IconButton(
                  onPressed:(){
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)
              ),
              expandedHeight: MediaQuery.of(context).size.width * (10/25)
                  + (MyPaddings.large * 8) + AppBar().preferredSize.height,
              flexibleSpace:FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: EdgeInsets.symmetric(horizontal : MyPaddings.large),
                  child: Column(children: [
                    SizedBox(height: AppBar().preferredSize.height,),
                    Material(child: Hero(tag: title, child: TopicCard(title: title, isBack: true,))),
                    SizedBox(height: MyPaddings.large),
                    SizedBox(height: MyPaddings.large*2,
                      child: Align(alignment: Alignment.centerLeft, child: MyText.h2('관련 키워드')),
                    ),
                    SizedBox(height: MyPaddings.large),
                    SizedBox(height: MyPaddings.large*3, child: Row(
                      children: [
                        _buildKeywordButton('관련 키워드 1', 0, true),
                        SizedBox(width: 8),
                        _buildKeywordButton('관련 키워드 2', 1, false),
                        SizedBox(width: 8),
                        _buildKeywordButton('더보기', 2, false),
                      ],
                    ),),
                    SizedBox(height: MyPaddings.large),
                  ]),
                ),
              )
          ),
          // FutureBuilder<Map<String, dynamic>?>(
          //   future: GetIssues().getIssues(),
          //   builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         if(snapshot.hasData && snapshot.data != null) {
          //           IssuesModel issuesModel = IssuesModel.fromJson(snapshot.data!);
          //           return SliverList(
          //             delegate: SliverChildBuilderDelegate((context, i) {
          //               return NewsCard(
          //                 issueModel: issuesModel.issues[i],
          //                 isDailyIssue: false,
          //
          //               );
          //             },
          //             childCount: issuesModel.issues.length),
          //           );
          //         } else if (snapshot.hasData && snapshot.data == null) {
          //           return SliverToBoxAdapter(
          //             child: Center(
          //               child: Text('No data available'),
          //             ),
          //           );
          //         } else {
          //           return SliverToBoxAdapter(
          //             child: Center(
          //               child: Text('No issues found'),
          //             ),
          //           );
          //         }
          //       } else if (snapshot.hasError) {
          //         return SliverToBoxAdapter(
          //           child: Center(
          //             child: Text('Error: ${snapshot.error}'),
          //           ),
          //         );
          //       }
          //       return SliverToBoxAdapter(child: LoadingView());
          //     }
          // ),
        ],
      )
    );
  }
}
