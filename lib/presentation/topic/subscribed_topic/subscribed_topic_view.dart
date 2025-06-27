import 'package:could_be/core/components/chips/issue_chip.dart';
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
                  top: MyPaddings.medium,
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
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.topics!.topics.length,
                            itemBuilder: (context, index) {
                              final topic = state.topics!.topics[index];
                              return TopicChip(
                                title: topic.name,
                                isActive: false,
                                onTap: () {},
                              );
                            },
                          ),
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
