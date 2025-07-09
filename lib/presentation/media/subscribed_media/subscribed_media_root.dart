import 'dart:async';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/loading/media_loading_view.dart';
import 'package:could_be/core/components/loading/news_list_loading_view.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/cards/news_card.dart';
import '../../../core/components/title/big_title_icon.dart';
import '../../../core/themes/margins_paddings.dart';
import '../media_profile_component.dart';
import 'subscribed_media_view_model.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/components/layouts/responsive_grid.dart';

class SubscribedMediaRoot extends StatefulWidget {
  const SubscribedMediaRoot({super.key});

  @override
  State<SubscribedMediaRoot> createState() => _SubscribedMediaRootState();
}

class _SubscribedMediaRootState extends State<SubscribedMediaRoot> {
  late SubscribedMediaViewModel viewModel;
  StreamSubscription? eventSubscription;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SubscribedMediaViewModel>();
    eventSubscription = viewModel.eventStream.listen((event) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(event.toString())));
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        viewModel.fetchMoreIssues(
          lastArticleId: viewModel.state.articles!.lastArticleId,
        );
      }
    });
  }

  @override
  dispose() {
    eventSubscription?.cancel();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.refreshArticles();
      },
      color: Colors.black,
      backgroundColor: Colors.white,
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          bool isSourcesEmpty =
              state.sources != null && state.sources!.sources.isEmpty;
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
            children: [
              RegAppBar(
                title: '관심 언론의 기사 보기',
                iconData: Icons.article_rounded,
              ),
              isSourcesEmpty? Center(
                child: EmptyTitleAdd(
                  title: '관심 언론을 추가해보세요.',
                  onTap: () {
                    context.push(RouteNames.wholeMedia);
                  },
                ),
              ):
              Padding(
                padding: EdgeInsets.only(
                  left: MyPaddings.largeMedium,
                  top: MyPaddings.medium,
                ),
                child: BigTitleAdd(
                  title: '관심 언론',
                  onTap: () {
                    context.push(RouteNames.wholeMedia);
                  },
                ),
              ),
              if(!isSourcesEmpty) Container(
                    margin: EdgeInsets.only(
                      top: MyPaddings.medium,
                    ),
                    height: 110,
                    child: Center(
                      child:
                          state.isSourcesLoading
                              ? MediaLoadingView()
                              : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final source = state.sources!.sources[index];
                                  return MediaProfile(
                                    isFirst: index == 0,
                                    source: source,
                                    isShowingArticles:
                                        source.id == state.selectedSourceId,
                                    onShowArticles: () {
                                      viewModel.setSelectedSourceId(source.id);
                                    },
                                  );
                                },
                                itemCount: state.sources!.sources.length,
                              ),
                    ),
                  ),
              // if (state.selectedSourceId != null)
              //   Align(
              //     alignment: Alignment.centerRight,
              //     child: Padding(
              //       padding: EdgeInsets.only(right: MyPaddings.large),
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.white,
              //           foregroundColor: Colors.black,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         onPressed: () {
              //           if (state.selectedSourceId != null) {
              //             context.push(
              //               RouteNames.mediaDetail,
              //               extra: state.selectedSourceId,
              //             );
              //           }
              //         },
              //         child: Text('언론 상세 정보'),
              //       ),
              //     ),
              //   ),
              state.isArticlesLoading
                  ? NewsListLoadingView()
                  : state.articles == null || state.articles!.articles.isEmpty
                  ? NotFound(notFoundType: NotFoundType.article)
                  : ResponsiveBuilder(
                      builder: (context, deviceType) {
                        if (ResponsiveUtils.isMobile(context)) {
                          // 모바일에서는 기존 Column 방식 유지
                          return Column(
                            children: [
                              for (int i = 0; i < state.articles!.articles.length; i++)
                                NewsCard(article: state.articles!.articles[i]),
                              if (state.isLoadingMore) NewsListLoadingView(),
                            ],
                          );
                        }

                        // 태블릿/데스크탑에서는 반응형 그리드 사용
                        return Column(
                          children: [
                            ResponsiveGrid(
                              children: state.articles!.articles
                                  .map((article) => NewsCard(article: article))
                                  .toList(),
                            ),
                            if (state.isLoadingMore) NewsListLoadingView(),
                          ],
                        );
                      },
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
