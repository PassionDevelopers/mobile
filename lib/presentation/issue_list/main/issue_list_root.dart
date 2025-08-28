import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/core/analytics/analytics_screen_names.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/cards/hot_issue_card.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/events/tab_reselection_event.dart';
import 'package:could_be/presentation/core/issue_list/infinite_scroll.dart';
import 'package:could_be/presentation/core/issue_list/refresh.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/di/di_setup.dart';
import '../../topic/subscribed_topic/subscribed_topic_view.dart';
import '../issue_list_loading_view.dart';
import '../issue_type.dart';
import 'issue_list_view.dart';
import 'issue_list_view_model.dart';

class IssueListRoot extends StatefulWidget {
  final IssueType issueType;
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
  });

  @override
  State<IssueListRoot> createState() => _IssueListRootState();
}

class _IssueListRootState extends State<IssueListRoot> {
  final ScrollController scrollController = ScrollController();
  late IssueListViewModel viewModel;
  late HotIssuesViewModel hotIssuesViewModel;
  StreamSubscription<int>? _tabReselectionSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt<IssueListViewModel>(
      param1: widget.issueType,
    );
    hotIssuesViewModel = getIt<HotIssuesViewModel>();

    infiniteScrollListener(scrollController: scrollController,
        onLoadMore: viewModel.fetchMoreIssues);

    // 탭 재선택 이벤트 리스닝
    _tabReselectionSubscription = TabReselectionEvent.stream.listen((tabIndex) {
      // 홈 탭(0)이 재선택되었을 때
      if (tabIndex == 0 && widget.isFeedView) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      // 토픽 탭(1)이 재선택되었을 때
      else if (tabIndex == 1 && widget.isTopicView) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      // 사각지대 탭(2)이 재선택되었을 때
      else if (tabIndex == 2 &&
          (widget.issueType == IssueType.blindSpotLeft ||
              widget.issueType == IssueType.blindSpotRight)) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabReselectionSubscription?.cancel();
    scrollController.dispose();
    viewModel.dispose();
    hotIssuesViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IssueListRefresher(
      onRefresh: () async {
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.pullToRefresh,
          parameters: {
            AnalyticsParameterKeys.screenName:
                widget.isFeedView
                    ? AnalyticsScreenNames.homeScreen
                    : widget.issueType.name,
          },
        );
        viewModel.fetchInitalIssues(
          topicId: viewModel.state.topicId,
          issueQueryParam: viewModel.state.issueQueryParam,
        );
        hotIssuesViewModel.fetchHotIssues();
      },
      content: SingleChildScrollView(
        controller: scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            widget.appBar ?? SizedBox.shrink(),
            if (widget.isFeedView)
              MainAppBar(onSearchSubmitted: viewModel.searchIssues),
            if (widget.isFeedView)
              IssueQueryParamsView(
                changeQueryParam: viewModel.changeQueryParam,
              ),
            if (widget.isTopicView)
              SubscribedTopicView(onTopicSelected: viewModel.changeTopicId),
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
                          builder: (context, _) {
                            bool isDailyQueryParam =
                                state.issueQueryParam != null &&
                                state.issueQueryParam!.queryParam ==
                                    IssueType.daily.name;
                            bool isDailyIssueType =
                                state.issueQueryParam == null &&
                                widget.issueType == IssueType.daily;
                            bool isSearching = state.query != null;
                            if (widget.isFeedView &&
                                (isDailyQueryParam || isDailyIssueType) &&
                                !isSearching &&
                                hotIssuesViewModel.state.hotIssues != null) {
                              return HotIssueCard(
                                updateTime:
                                    hotIssuesViewModel.state.hotIssues!.hotTime,
                                hotIssues: hotIssuesViewModel.state.hotIssues!,
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        IssueListView(
                          issueList: state.issueList,
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
