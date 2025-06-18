import 'package:flutter/material.dart';
import '../../core/components/topic_components.dart';
import '../themes/margins_paddings.dart';

class TopicHomeView extends StatelessWidget {
  TopicHomeView({super.key});

  final List<String> topics = [
    '정치',
    '경제',
    '사회',
    '문화',
    '과학',
    '기술',
    '스포츠',
    '연예',
    '국제',
    '환경',
    '건강',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MyPaddings.medium),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: MyPaddings.medium,
          mainAxisSpacing: MyPaddings.medium,
        ),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Hero(tag:topics[index], child: TopicCard(title: topics[index], isBack: false,));
        },
      ),
    );
  }
}
