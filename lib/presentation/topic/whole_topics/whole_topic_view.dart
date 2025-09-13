import 'dart:developer';

import 'package:could_be/core/components/app_bar/center_title_app_bar.dart';
import 'package:could_be/core/components/app_bar/reg_app_bar.dart';
import 'package:could_be/presentation/search/search_field.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/topic/topic.dart';
import 'package:could_be/presentation/topic/whole_topics/category_topic_view.dart';
import 'package:could_be/presentation/topic/whole_topics/topic_list_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_loading_view.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_state.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/cards/topic_card.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/themes/margins_paddings.dart';

class WholeTopicView extends StatelessWidget {
  const WholeTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: true,
      body: Column(
        children: [
          CenterTitleAppBar(title: '토픽 둘러보기', prefix: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.black,),
          ), action: GestureDetector(
            onTap: (){
              context.push(RouteNames.search);
            },
            child: Icon(Icons.search, color: AppColors.black,),
          ),),
          Expanded(child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Material(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TabBar(tabs: [
                      for(final category in Categories.values) Tab(child: MyText.reg(category.name))
                    ],
                      labelColor: AppColors.black,
                      unselectedLabelColor: AppColors.gray400,
                      indicatorColor: AppColors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ),
                Expanded(
                  child: Ink(
                    color: AppColors.white,
                    child: TabBarView(
                      children: [
                        for(final category in Categories.values) CategoryTopicView(category: category)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
