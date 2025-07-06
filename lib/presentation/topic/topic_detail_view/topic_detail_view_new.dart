import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/components/cards/issue_card.dart';
import '../../../core/themes/margins_paddings.dart';
import 'topic_detail_view_model.dart';

class TopicDetailViewNew extends StatelessWidget {
  const TopicDetailViewNew({super.key, required this.topicId});
  final String topicId;

  final Color primary = const Color(0xff0A0A0B);
  final Color primaryLight = Colors.white;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<TopicDetailViewModel>(param1: topicId);
    return MyScaffold(
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
                      : Column(
                    children: [
                      for (int i = 0; i < state.topicDetail!.recentIssues.issues.length; i++)
                        IssueCard(issue: state.topicDetail!.recentIssues.issues[i], isDailyIssue: false),
                    ],
                  ),

                ],
              ),
            );
          }
        }
      ),
    );
  }
}