import 'dart:developer';

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/cards/hot_issue_card.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../../core/di/di_setup.dart';
import '../../topic/subscribed_topic/subscribed_topic_view.dart';
import '../issue_list_loading_view.dart';
import '../issue_type.dart';
import 'issue_list_view.dart';
import 'issue_list_view_model.dart';

class IssueListRoot extends StatefulWidget {
  final IssueType issueType;
  final String? topicId;
  final Widget? appBar;
  final Widget? upperWidget;
  final bool isFeedView;
  final bool isTopicView;
  final bool isEvaluatedView;

  const IssueListRoot({
    super.key,
    this.appBar,
    this.upperWidget,
    this.isFeedView = false,
    this.isTopicView = false,
    this.isEvaluatedView = false,
    required this.issueType,
    this.topicId,
  });

  @override
  State<IssueListRoot> createState() => _IssueListRootState();
}

class _IssueListRootState extends State<IssueListRoot> {
  final ScrollController scrollController = ScrollController();
  late IssueListViewModel viewModel;
  late HotIssuesViewModel hotIssuesViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt<IssueListViewModel>(
      param1: widget.issueType,
      param2: widget.topicId,
    );
    hotIssuesViewModel = getIt<HotIssuesViewModel>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        viewModel.fetchMoreIssues();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    viewModel.dispose();
    hotIssuesViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for(int i = 0; i < 100; i++)
          ListTile(
            title: Text('Item $i'),
          ),
      ],
    );
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.fetchInitalIssues(topicId: widget.topicId, issueQueryParam: viewModel.state.issueQueryParam);
        hotIssuesViewModel.fetchHotIssues();
      },
      backgroundColor: AppColors.primaryLight,
      color: AppColors.primary,

      child: NotificationListener(
        onNotification: (ScrollNotification scrollNotification) {
          final maxScroll = scrollNotification.metrics.maxScrollExtent;
          final currentScroll = scrollNotification.metrics.pixels;
          final delta = MediaQuery.of(context).size.height * 0.50;
          if (maxScroll - currentScroll <= delta) {
            viewModel.fetchMoreIssues();
          }
          return false;
        },
        child: ListView(
          children: [
            for(int i = 0; i < 100; i++)
              ListTile(
                title: Text('Item $i'),
              ),
          ],
        ),
      ),
    );
  }
}
