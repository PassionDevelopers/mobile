import 'package:could_be/core/components/app_bar/search_field.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/entities/topic.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_loading_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../core/components/cards/topic_card.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/themes/margins_paddings.dart';

class WholeTopicView extends StatelessWidget {
  const WholeTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    final WholeTopicViewModel viewModel = getIt<WholeTopicViewModel>(
      param1: Categories.politics.id,
    );
    return RegScaffold(
      isScrollPage: true,
      body: CustomScrollView(
        slivers: [
          // 헤더 섹션
          SliverToBoxAdapter(
            child: Column(
              children: [
                SearchAppBar(
                  backButtonVisible: true,
                  appBar: MyText.h2('토픽 둘러보기'),
                  onSearchSubmitted: viewModel.searchTopics,
                ),
                ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    final state = viewModel.state;
                    return Container(
                      color: AppColors.white,
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: MyPaddings.large),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 헤더 정보
                          // Container(
                          //   padding: EdgeInsets.all(MyPaddings.large),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Container(
                          //             padding: EdgeInsets.all(MyPaddings.medium),
                          //             decoration: BoxDecoration(
                          //               color: AppColors.primary.withOpacity(0.1),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             child: Icon(
                          //               Icons.tag,
                          //               color: AppColors.primary,
                          //               size: 24,
                          //             ),
                          //           ),
                          //           SizedBox(width: MyPaddings.medium),
                          //           Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 '관심 토픽 설정',
                          //                 style: MyFontStyle.h1.copyWith(
                          //                   color: AppColors.primary,
                          //                   fontWeight: FontWeight.w600,
                          //                 ),
                          //               ),
                          //               Text(
                          //                 '관심있는 토픽을 구독하고 이슈를 받아보세요',
                          //                 style: MyFontStyle.small.copyWith(
                          //                   color: AppColors.gray2,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // 카테고리 필터
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MyPaddings.large,
                                  vertical: MyPaddings.small,
                                ),
                                child:
                                    state.isShowSearchedTopics
                                        ? TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          onPressed: () {
                                            viewModel.hideSearchedTopics();
                                          },
                                          child: MyText.h3(
                                            '뒤로 가기',
                                            color: AppColors.gray2,
                                          ),
                                        )
                                        : MyText.h3(
                                          '카테고리별 보기',
                                          color: AppColors.gray2,
                                        ),
                              ),
                              SizedBox(
                                height: 40,
                                child:
                                    state.isShowSearchedTopics
                                        ? Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MyPaddings.large,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: MyText.h3(
                                              '검색어 : #${state.query}',
                                              color: AppColors.gray1,
                                            ),
                                          ),
                                        )
                                        : ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MyPaddings.large,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: Categories.values.length,
                                          itemBuilder: (context, index) {
                                            final Categories category =
                                                Categories.values.elementAt(
                                                  index,
                                                );
                                            return _buildFilterChip(
                                              isSelected:
                                                  viewModel.state.categoryNow ==
                                                  category,
                                              onTap: viewModel.setCategoryNow,
                                              category: category,
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          CategoryPartSliver(viewModel: viewModel),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required Categories category,
    required bool isSelected,
    required void Function(Categories category) onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: MyPaddings.small),
      child: InkWell(
        onTap: () {
          onTap(category);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.large,
            vertical: MyPaddings.small,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.gray4,
            ),
          ),
          child: Center(
            child: MyText.reg(
              category.name,
              color: isSelected ? AppColors.white : AppColors.primary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPartSliver extends StatelessWidget {
  const CategoryPartSliver({super.key, required this.viewModel});

  final WholeTopicViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        if (state.isLoading) {
          return WholeTopicLoadingView();
        } else if (state.isShowSearchedTopics) {
          final Map<Categories, List<Topic>> topics =
              state.searchedTopics ?? {};
          List<Widget> slivers = [];
          for (final category in Categories.values) {
            if (topics[category] != null && topics[category]!.isNotEmpty) {
              slivers.add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MyPaddings.large,
                      vertical: MyPaddings.small,
                    ),
                    child: MyText.h2(category.name),
                  ),
                ),
              );
              slivers.add(
                TopicListView(
                  topics: topics[category]!,
                  manageTopicSubscription: viewModel.manageTopicSubscription,
                ),
              );
            }
          }
          if (slivers.isEmpty) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '검색 결과가 없습니다',
                    style: MyFontStyle.reg.copyWith(color: AppColors.gray3),
                  ),
                ),
              ),
            );
          }
          slivers.add(
            BottomSafePadding()
          );
          return SliverPadding(
            padding: EdgeInsets.all(MyPaddings.small),
            sliver: SliverMainAxisGroup(slivers: slivers),
          );
        } else if (state.topics == null || state.topics!.topics.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  '아직 토픽이 없습니다',
                  style: MyFontStyle.reg.copyWith(color: AppColors.gray3),
                ),
              ),
            ),
          );
        } else {
          final topics = state.topics!.topics;
          return SliverPadding(
            padding: EdgeInsets.all(MyPaddings.small),
            sliver: SliverMainAxisGroup(
              slivers: [
                TopicListView(
                  topics: topics,
                  manageTopicSubscription: viewModel.manageTopicSubscription,
                ),
                BottomSafePadding()
              ],
            ),
          );
        }
      },
    );
  }
}

class TopicListView extends StatelessWidget {
  const TopicListView({
    super.key,
    required this.topics,
    required this.manageTopicSubscription,
  });

  final List<Topic> topics;
  final void Function(String topicId) manageTopicSubscription;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: MyPaddings.small,
        mainAxisSpacing: MyPaddings.small,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final topic = topics[index];
        return TopicCard(
          isSelected: topic.isSubscribed,
          topic: topic,
          onTap: () {
            manageTopicSubscription(topic.id);
          },
        );
      }, childCount: topics.length),
    );
  }
}
