import 'package:could_be/core/components/chips/topic_chip.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/title/big_title_icon.dart';
import '../../../core/routes/route_names.dart';

class SubscribedTopicView extends StatelessWidget {
  const SubscribedTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SubscribedTopicViewModel>();
    return SingleChildScrollView(
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MyPaddings.largeMedium,
                  vertical: MyPaddings.small,
                ),
                child: BigTitleAdd(title: '관심 토픽', onTap: () {
                  context.push(RouteNames.wholeTopics);
                }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MyPaddings.large,
                    left: MyPaddings.largeMedium),
                child:
                    SizedBox(
                      height: 42,
                      child: state.isTopicLoading
                        ? Center(child: CircularProgressIndicator())
                        : state.topics == null || state.topics!.topics.isEmpty
                        ? Center(child: Text('관심 토픽이 없습니다.'))
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.topics!.topics.length,
                          itemBuilder: (context, index) {
                            final topic = state.topics!.topics[index];
                            return TopicChip(
                              title: topic.name,
                              isActive: topic.id == state.selectedTopicId,
                              onTap: () {
                                viewModel.setSelectedTopicId(topic.id);
                              },
                            );
                          },
                        ),
                    ),
              ),
              if(state.selectedTopicId != null) Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: MyPaddings.large, top: MyPaddings.small),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ), onPressed: (){
                    if(state.selectedTopicId != null) {
                      context.push(RouteNames.topicDetail, extra: state.selectedTopicId);
                    }
                  }, child: Text('토픽 상세 정보')),
                ),
              ),
              SizedBox(height: MyPaddings.large),
              IssueListRoot(issueType: IssueType.subscribedTopicIssuesWhole)
            ],
          );
        },
      ),
    );
  }
}
