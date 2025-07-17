import 'package:could_be/core/components/cards/news_card.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/presentation/web_view/web_view_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/method/bias/bias_enum.dart';
import '../../domain/entities/article.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/responsive/responsive_utils.dart';

class WebViewView extends StatelessWidget {
  const WebViewView({
    super.key,
    this.articles,
    this.issueId,
    this.bias,
    this.selectedArticleId,
    this.selectedSourceId,
  });

  final List<Article>? articles;
  final String? selectedArticleId;
  final String? selectedSourceId;
  final String? issueId;
  final Bias? bias;

  @override
  Widget build(BuildContext context) {
    final viewModel = WebViewViewModel(
      fetchArticlesUseCase: getIt(),
      trackUserActivityUseCase: getIt(),
      issueId: issueId, // widget.issueId,
      bias: bias,
      articles: articles,
      selectedArticleId: selectedArticleId,
      selectedSourceId: selectedSourceId,
    );

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return RegScaffold(
      body: ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        final sources = state.articlesGroupBySource?.sources ?? [];
        final articles = state.articlesGroupBySource?.articlesWithSources[state.currentSourceId] ?? [];
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.articlesGroupBySource == null ||
            state.articlesGroupBySource!.articlesWithSources.isEmpty) {
          return Center(child: Text('해당 이슈에 대한 기사가 없습니다.'));
        } else {
          return SlidingUpPanel(
            panel: Ink(
              padding: EdgeInsets.symmetric(horizontal: MyPaddings.medium),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: radius,
              ),
              child: Column(
                children: [
                  Icon(Icons.drag_handle_rounded, color: AppColors.primary),
                  SizedBox(
                    height: 70,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final source = state.articlesGroupBySource!.sources[index];
                              return MediaProfileWebView(
                                source: source,
                                isShowingArticles: state.currentSourceId == source.id,
                                onShowArticles: () {
                                  viewModel.changeCurrentSourceId(source.id);
                                },
                              );
                            },
                            itemCount: state.articlesGroupBySource!.sources
                                .length,
                            shrinkWrap: true,
                        )
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
                          isSelected: state.currentArticleId == articles[index].id &&
                              state.currentSourceId ==
                                  articles[index].source.id,
                          onWebViewSelected: () {
                            viewModel.changeCurrentArticleId(articles[index].id);
                          },
                        );
                      },
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
            // collapsed: Ink(
            //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.medium),
            //   decoration: BoxDecoration(
            //     color: AppColors.background,
            //     borderRadius: radius,
            //   ),
            //   child: Column(
            //     children: [
            //       Icon(Icons.drag_handle_rounded, color: AppColors.primary),
            //       Expanded(
            //         child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (context, index) {
            //               final source = state.articlesGroupBySource!.sources[index];
            //               return MediaProfileWebView(
            //                 source: source,
            //                 isShowingArticles: source.id == state.currentSourceId,
            //                 onShowArticles: () {
            //                   viewModel.changeCurrentSourceId(source.id);
            //                 },
            //               );
            //             },
            //             itemCount:
            //             state.articlesGroupBySource!.sources.length,
            //             shrinkWrap: true,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            body: WebViewWidget(controller: viewModel.state.controller!),
            borderRadius: radius,
          );
        }
      },
      ),
    );
  }
}
