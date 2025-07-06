import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_loading_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/cards/topic_card.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/themes/margins_paddings.dart';

class WholeTopicView extends StatelessWidget {
  const WholeTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModelPolitic = getIt<WholeTopicViewModel>(param1: 'politics');
    final viewModelEconomy = getIt<WholeTopicViewModel>(param1: 'economy');
    final viewModelSociety = getIt<WholeTopicViewModel>(param1: 'society');
    final viewModelCulture = getIt<WholeTopicViewModel>(param1: 'culture');
    final viewModelWorld = getIt<WholeTopicViewModel>(param1: 'international');
    final viewModelIt = getIt<WholeTopicViewModel>(param1: 'technology');

    return MyScaffold(
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            RegAppBar(title: '관심 토픽 설정'),
            Material(
              color: AppColors.primaryLight,
              child: TabBar(
                tabs: [
                  Tab(text: '정치'),
                  Tab(text: '경제'),
                  Tab(text: '사회'),
                  Tab(text: '문화'),
                  Tab(text: '세계'),
                  Tab(text: '기술'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CategoryPartView(title: '정치', viewModel: viewModelPolitic),
                  CategoryPartView(title: '경제', viewModel: viewModelEconomy),
                  CategoryPartView(title: '사회', viewModel: viewModelSociety),
                  CategoryPartView(title: '문화', viewModel: viewModelCulture),
                  CategoryPartView(title: '세계', viewModel: viewModelWorld),
                  CategoryPartView(title: '기술', viewModel: viewModelIt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPartView extends StatelessWidget {
  const CategoryPartView({
    super.key,
    required this.title,
    required this.viewModel,
  });

  final String title;
  final WholeTopicViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        if (state.isLoading) {
          return WholeTopicLoadingView();
        } else if (state.topics!.topics.isEmpty || state.topics == null) {
          return Center(child: Text('아직 토픽이 없습니다'));
        } else {
          final topics = state.topics!.topics;
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
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              // return Hero(tag:topics[index], child: TopicCard(title: topic.name, isBack: false,));
              // return TopicChip(title: topic.name,
              //     isActive: false, onTap: (){});
              return TopicCard(
                topic: topic,
                onTapSubscribe: () {
                  viewModel.manageTopicSubscription(topic.id);
                },
                onTap: () {
                  context.push(
                    RouteNames.topicDetail,
                    extra: topic.id,
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
