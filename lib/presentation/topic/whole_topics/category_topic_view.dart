import 'dart:developer';

import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_loading_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:flutter/material.dart';

import 'topic_list_view.dart';

class CategoryTopicView extends StatelessWidget {
  const CategoryTopicView({super.key, required this.category});

  final Categories category;

  @override
  Widget build(BuildContext context) {
    final WholeTopicViewModel viewModel = getIt<WholeTopicViewModel>(
      param1: category.id,
    );
    return ListenableBuilder(listenable: viewModel, builder: (context, _) {
      final state = viewModel.state;
      if (state.isLoading) {
        return WholeTopicLoadingView();
      } else if (state.topics == null || state.topics!.topics.isEmpty) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Text(
              '아직 토픽이 없습니다',
              style: MyFontStyle.reg.copyWith(color: AppColors.gray500),
            ),
          ),
        );
      } else {
        final topics = state.topics!.topics;
        log('topics length: ${topics.length}');
        return Padding(
          padding: EdgeInsets.all(MyPaddings.small),
          child: Column(
            children: [
              Expanded(
                child: TopicListView(
                  topics: topics,
                  manageTopicSubscription: viewModel.manageTopicSubscription,
                ),
              ),
              BottomSafePadding()
            ],
          ),
        );
      }
    });
  }
}
