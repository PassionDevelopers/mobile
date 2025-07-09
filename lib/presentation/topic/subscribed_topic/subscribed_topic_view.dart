import 'package:could_be/core/components/chips/topic_chip.dart';
import 'package:could_be/core/components/loading/chip_loading_view.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/topic/subscribed_topic/subscribed_topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/title/big_title_icon.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/components/layouts/responsive_grid.dart';

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
          isTopicEmpty
              ? Center(
            child: EmptyTitleAdd(
              title: '관심 토픽을 추가해보세요.',
              onTap: () {
                context.push(RouteNames.wholeTopics);
              },
            ),
          )
              : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MyPaddings.largeMedium,
              vertical: MyPaddings.small,
            ),
            child: BigTitleAdd(
              title: '관심 토픽',
              onTap: () {
                context.push(RouteNames.wholeTopics);
              },
            ),
          ),
          if (!isTopicEmpty)
            ResponsiveBuilder(
              builder: (context, deviceType) {
                if (state.isTopicLoading) {
                  return ChipLoadingView();
                }

                // 모바일에서는 가로 스크롤, 태블릿/데스크탑에서는 Wrap 사용
                if (ResponsiveUtils.isMobile(context)) {
                  return SizedBox(
                    height: 42,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.topics!.topics.length,
                      itemBuilder: (context, index) {
                        final topic = state.topics!.topics[index];
                        return TopicChip(
                          padding: index == 0 ? MyPaddings.largeMedium : null,
                          title: topic.name,
                          isActive: topic.id == state.selectedTopicId,
                          onTap: () {
                            if (topic.id != state.selectedTopicId) {
                              onTopicSelected!(topic.id);
                            } else {
                              onTopicSelected!(null);
                            }
                            viewModel.setSelectedTopicId(topic.id);
                          },
                        );
                      },
                    ),
                  );
                }

                // 태블릿/데스크탑에서는 ResponsiveWrap 사용
                return ResponsiveWrap(
                  children: state.topics!.topics.map((topic) {
                    return TopicChip(
                      title: topic.name,
                      isActive: topic.id == state.selectedTopicId,
                      onTap: () {
                        if (topic.id != state.selectedTopicId) {
                          onTopicSelected!(topic.id);
                        } else {
                          onTopicSelected!(null);
                        }
                        viewModel.setSelectedTopicId(topic.id);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          // if (state.selectedTopicId != null)
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: Padding(
          //       padding: EdgeInsets.only(
          //         right: MyPaddings.large,
          //         top: MyPaddings.small,
          //       ),
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.white,
          //           foregroundColor: Colors.black,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //         ),
          //         onPressed: () {
          //           if (state.selectedTopicId != null) {
          //             context.push(
          //               RouteNames.topicDetail,
          //               extra: state.selectedTopicId,
          //             );
          //           }
          //         },
          //         child: Text('토픽 상세 정보'),
          //       ),
          //     ),
          //   ),
          SizedBox(height: MyPaddings.large),
          ],
        );
      },
    );
  }
}
