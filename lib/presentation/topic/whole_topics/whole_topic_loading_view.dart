import 'package:could_be/core/components/loading/topic_card_skeleton.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/cupertino.dart';

class WholeTopicLoadingView extends StatelessWidget {
  const WholeTopicLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.largeMedium,
        vertical: MyPaddings.medium,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return const TopicCardSkeleton();
        }))
    );
  }
}
