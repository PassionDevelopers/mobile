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
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.fetchInitalIssues(topicId: widget.topicId);
        hotIssuesViewModel.fetchHotIssues();
      },
      backgroundColor: AppColors.primaryLight,
      color: AppColors.primary,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            widget.appBar ?? SizedBox.shrink(),
            if(widget.isFeedView) MainAppBar(
                onSearchSubmitted: viewModel.searchIssues,
                onNoticePressed: viewModel.showNoticeDialog,
            ),
            if(widget.isFeedView) IssueQueryParamsView(
              changeQueryParam: viewModel.changeQueryParam,
            ),
            if(widget.isTopicView) SubscribedTopicView(
              onTopicSelected: viewModel.changeTopicId,
            ),
            widget.upperWidget ?? SizedBox.shrink(),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final state = viewModel.state;
                log('IssueQueryParam: ${state.issueQueryParam?.queryParam}');
                if (state.isLoading) {
                  return IssueListLoadingView();
                } else {
                  if (state.issueList.isEmpty) {
                    return NotFound(notFoundType: NotFoundType.issue);
                  } else {
                    return Column(
                      children: [
                        ListenableBuilder(
                          listenable: hotIssuesViewModel,
                          builder: (context, _){
                            bool isDailyQueryParam = state.issueQueryParam != null && state.issueQueryParam!.queryParam == IssueType.daily.name;
                            bool isDailyIssueType = state.issueQueryParam == null && widget.issueType == IssueType.daily;
                            bool isSearching = state.query != null;
                            log('isDailyQueryParam: $isDailyQueryParam, isDailyIssueType: $isDailyIssueType, isSearching: $isSearching');
                            if(widget.isFeedView && (isDailyQueryParam || isDailyIssueType) && !isSearching && hotIssuesViewModel.state.hotIssues != null){
                              return HotIssueCard(
                                updateTime: hotIssuesViewModel.state.hotIssues!.hotTime,
                                hotIssues: hotIssuesViewModel.state.hotIssues!,
                              );
                            }
                            return SizedBox.shrink();
                          }
                        ),
                        IssueListView(issueList: state.issueList,
                          onBiasSelected: viewModel.manageIssueEvaluation,
                          isEvaluating: state.isEvaluating,
                          isEvaluatedView: widget.isEvaluatedView,
                        ),
                        if (state.isLoadingMore) IssueListLoadingView(),
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
