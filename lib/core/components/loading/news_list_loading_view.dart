import 'package:could_be/core/components/loading/news_card_skeleton.dart';
import 'package:flutter/cupertino.dart';

class NewsListLoadingView extends StatelessWidget {
  const NewsListLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          10,
          (index) => NewsCardSkeleton()
        ),
      ),
    );
  }
}
