import 'package:could_be/core/components/loading/topic_card_skeleton.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/cupertino.dart';

class WholeTopicLoadingView extends StatelessWidget {
  const WholeTopicLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.largeMedium,
        vertical: MyPaddings.medium,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        return TopicCardSkeleton();
      },
    );
  }
}
