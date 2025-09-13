import 'package:could_be/core/components/cards/topic_card.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:flutter/material.dart';

class TopicListView extends StatelessWidget {
  const TopicListView({
    super.key,
    required this.topics,
    required this.manageTopicSubscription,
  });

  final List<Topic> topics;
  final void Function({required String topicId, required BuildContext context}) manageTopicSubscription;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: MyPaddings.small,
        mainAxisSpacing: MyPaddings.small,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index){
        final topic = topics[index];
        return TopicCard(
          isSelected: topic.isSubscribed,
          topic: topic,
          onTap: () {
            manageTopicSubscription(
              topicId: topic.id,
              context: context,
            );
          },
        );
      },
    );
  }
}