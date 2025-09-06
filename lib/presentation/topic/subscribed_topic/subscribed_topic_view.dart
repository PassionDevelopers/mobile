import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/cards/topic_card.dart';
import 'package:could_be/core/components/loading/chip_loading_view.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/responsive_layout.dart';
import '../../../core/routes/route_names.dart';
import '../../../ui/color.dart' show AppColors;

class SubscribedTopicView extends StatelessWidget {
  const SubscribedTopicView({super.key, this.onTopicSelected});

  final void Function(String? topicId)? onTopicSelected;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SubscribedTopicViewModel>();
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        bool isTopicEmpty = state.topics != null && state.topics!.topics.isEmpty;
        return Column(
          children: [
            Column(
              children: [
                RegAppBar(title: '관심 토픽의 이슈 보기', iconData: Icons.explore_rounded),
                // 헤더 섹션
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                    vertical: MyPaddings.medium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.h0(
                            '관심 토픽',
                            color: AppColors.primary,
                          ),
                          SizedBox(height: MyPaddings.small),
                          if (!state.isTopicLoading)
                            Text(
                              '${state.topics!.topics.length}개 토픽 구독 중',
                              style: MyFontStyle.reg.copyWith(
                                color: AppColors.gray2,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: MyPaddings.large),
                      InkWell(
                        onTap: () {
                          context.push(RouteNames.wholeTopics);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: EdgeInsets.all(MyPaddings.medium),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isTopicEmpty)
              ResponsiveBuilder(
                builder: (context, deviceType) {
                  if (state.isTopicLoading) {
                    return ChipLoadingView();
                  }
                  return SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: MyPaddings.large,
                      ),
                      itemCount: state.topics!.topics.length,
                      itemBuilder: (context, index) {
                        final topic = state.topics!.topics[index];
                        return Container(
                          width: 110,
                          padding: EdgeInsets.only(right: MyPaddings.extraSmall),
                          child: TopicCard(
                            isSelected: state.selectedTopicId == topic.id,
                            topic: topic,
                            onTap: () {
                              if (topic.id != state.selectedTopicId) {
                                onTopicSelected!(topic.id);
                              } else {
                                onTopicSelected!(null);
                              }
                              viewModel.setSelectedTopicId(topic.id);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            SizedBox(height: MyPaddings.large),
          ],
        );
      },
    );
  }
}
