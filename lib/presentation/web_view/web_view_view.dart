import 'package:could_be/core/components/cards/news_card.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../domain/entities/article.dart';

class WebViewView extends StatelessWidget {
  const WebViewView({super.key, this.article, this.issueId, this.bias});

  final Article? article;
  final String? issueId;
  final Bias? bias;

  @override
  Widget build(BuildContext context) {
    final viewModel = WebViewViewModel(
      fetchArticlesUseCase: getIt(),
      issueId: issueId, // widget.issueId,
      bias: bias,
      article: article,
    );

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return MyScaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          final sources = state.articlesGroupBySource?.sources ?? [];
          final articles =
              state
                  .articlesGroupBySource
                  ?.articlesWithSources[sources[state.currentSourceIndex].id] ??
              [];
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.articlesGroupBySource == null ||
              state.articlesGroupBySource!.articlesWithSources.isEmpty) {
            return Center(child: Text('해당 이슈에 대한 기사가 없습니다.'));
          } else {
            return SlidingUpPanel(
              panel: Ink(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: radius,
                ),
                child: Column(
                  children: [
                    Icon(Icons.drag_handle_rounded, color: AppColors.primary),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MediaProfileWebView(
                            source: state.articlesGroupBySource!.sources[index],
                            isShowingArticles:
                                index == state.currentSourceIndex,
                            onShowArticles: () {
                              viewModel.changeCurrentSourceIndex(index);
                            },
                          );
                        },
                        itemCount: state.articlesGroupBySource!.sources.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    SizedBox(height: 4),
                    Divider(color: AppColors.gray5, height: 1),
                    SizedBox(height: 4),
                    Expanded(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            article: articles[index],
                            isSelected:
                                state.currentArticleIndex == index &&
                                sources[state.currentSourceIndex].id == articles[index].source.id,
                            onWebViewSelected: () {
                              viewModel.changeCurrentArticleIndex(index);
                            },
                          );
                        },
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              ),
              collapsed: Ink(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: radius,
                ),
                child: Column(
                  children: [
                    Icon(Icons.drag_handle_rounded, color: AppColors.primary),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MediaProfileWebView(
                            source: state.articlesGroupBySource!.sources[index],
                            isShowingArticles:
                                index == state.currentSourceIndex,
                            onShowArticles: () {
                              viewModel.changeCurrentSourceIndex(index);
                            },
                          );
                        },
                        itemCount: state.articlesGroupBySource!.sources.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              ),

              body: WebViewWidget(controller: viewModel.state.controller!),

              borderRadius: radius,
            );
          }
        },
      ),
    );
  }
}
