import 'package:flutter/material.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../../core/di/di_setup.dart';
import 'components/loading_indicator.dart';
import 'components/news_feed_card.dart';
import 'shorts_player_view_model.dart';

class ShortsPlayerView extends StatefulWidget {
  const ShortsPlayerView({super.key, required this.issueId});
  final String issueId;

  @override
  State<ShortsPlayerView> createState() => _ShortsPlayerViewState();
}

class _ShortsPlayerViewState extends State<ShortsPlayerView> {
  late PageController _pageController;
  late ShortsPlayerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _viewModel = ShortsPlayerViewModel(
      fetchIssueDetailUseCase: getIt(),
      issueId: widget.issueId,
    );
    _viewModel.loadInitialContent(widget.issueId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showAppBar: false,
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.issueDetail.isEmpty && _viewModel.isLoading) {
            return const ShortsLoadingIndicator();
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemCount: _viewModel.issueDetail.length + (_viewModel.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= _viewModel.issueDetail.length) {
                return const ShortsLoadingIndicator();
              }

              final content = _viewModel.issueDetail[index];
              return NewsFeedCard(
                content: content,
                isActive: index == _viewModel.currentIndex,
                onBack: () => Navigator.of(context).pop(),
                onSubscribeToggle: () => _viewModel.toggleSubscription(content.id),
                onShare: () => _viewModel.shareContent(content),
                onViewArticle: () => _viewModel.viewOriginalArticle(content),
                onAnalyzeDifference: () => _viewModel.analyzeDifference(content),
              );
            },
          );
        },
      ),
    );
  }
}