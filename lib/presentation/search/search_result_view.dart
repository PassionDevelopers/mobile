import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:could_be/presentation/topic/whole_topics/topic_list_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:flutter/material.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key, required this.searchedTopics, required this.manageTopicSubscription});

  final Map<Categories, List<Topic>> searchedTopics;
  final void Function({required String topicId, required BuildContext context}) manageTopicSubscription;

  _buildResultView() {
    List<Widget> result = [];
    for (final category in Categories.values) {
      if (searchedTopics[category] != null && searchedTopics[category]!.isNotEmpty) {
        result.add(
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MyPaddings.large,
              vertical: MyPaddings.small,
            ),
            child: MyText.h2(category.name),
          ),
        );
        result.add(
          TopicListView(
            topics: searchedTopics[category]!,
            manageTopicSubscription: manageTopicSubscription,
          ),
        );
      }
    }
    if (result.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: Center(
            child: Text(
              '검색 결과가 없습니다',
              style: MyFontStyle.reg.copyWith(color: AppColors.gray300),
            ),
          ),
        ),
      );
    }
    result.add(
        BottomSafePadding()
    );
    return Padding(
      padding: EdgeInsets.all(MyPaddings.small),
      child: Column(children: result),
    );
}

  @override
  Widget build(BuildContext context) {
    return _buildResultView();
  }

}
