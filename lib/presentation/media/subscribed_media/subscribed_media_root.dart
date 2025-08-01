import 'dart:async';
import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/loading/media_loading_view.dart';
import 'package:could_be/core/components/loading/news_list_loading_view.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
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
                isSourcesEmpty
                    ? Container(
                      height: 300,
                      margin: EdgeInsets.all(MyPaddings.extraLarge),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper_outlined,
                              size: 80,
                              color: AppColors.gray3,
                            ),

                            SizedBox(height: MyPaddings.large),
                            Text(
                              '아직 관심 언론이 없습니다',
                              style: MyFontStyle.h1.copyWith(
                                color: AppColors.gray2,
                              ),
                            ),
                            SizedBox(height: MyPaddings.small),
                            Text(
                              '다양한 언론사를 구독해보세요',
                              style: MyFontStyle.reg.copyWith(
                                color: AppColors.gray3,
                              ),
                            ),

                            SizedBox(height: MyPaddings.extraLarge),
                            InkWell(
                              onTap: () {
                                context.push(RouteNames.wholeMedia);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Ink(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MyPaddings.extraLarge,
                                  vertical: MyPaddings.large,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add, color: AppColors.white),
                                    SizedBox(width: MyPaddings.small),
                                    Text(
                                      '언론사 둘러보기',
                                      style: MyFontStyle.h3.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Column(
                      children: [
                        // 헤더 섹션
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MyPaddings.large,
                            vertical: MyPaddings.medium,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '관심 언론',
                                    style: MyFontStyle.h0.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: MyPaddings.small),
                                  if (!state.isSourcesLoading)
                                    Text(
                                      '${state.sources!.sources.length}개 언론사 구독 중',
                                      style: MyFontStyle.reg.copyWith(
                                        color: AppColors.gray2,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(width: MyPaddings.large),
                              InkWell(
                                onTap: () {
                                  context.push(RouteNames.wholeMedia);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: EdgeInsets.all(MyPaddings.medium),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 언론사 리스트
                        SizedBox(
                          height: 120,
                          child:
                              state.isSourcesLoading
                                  ? MediaLoadingView()
                                  : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final source =
                                          state.sources!.sources[index];
                                      return MediaProfile(
                                        isFirst: index == 0,
                                        source: source,
                                        isShowingArticles:
                                            source.id == state.selectedSourceId,
                                        onShowArticles: () {
                                          viewModel.setSelectedSourceId(
                                            source.id,
                                          );
                                        },
                                      );
                                    },
                                    itemCount: state.sources!.sources.length,
                                  ),
                        ),
                      ],
                    ),
                // 기사 섹션
                if (!isSourcesEmpty)
                  Container(
                    margin: EdgeInsets.only(top: MyPaddings.small),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // // 기사 헤더
                        if (state.selectedSourceId != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: MyPaddings.large,
                              vertical: MyPaddings.medium,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText.h2('최신 기사'),
                                if (state.selectedSourceId != null)
                                  InkWell(
                                    onTap: () {
                                      context.push(
                                        RouteNames.mediaDetail,
                                        extra: state.selectedSourceId,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        MyText.reg(
                                          '언론사 상세보기',
                                          color: AppColors.gray2,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: AppColors.gray2,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        // 기사 리스트
                        state.isArticlesLoading
                            ? Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: MyPaddings.large,
                              ),
                              child: NewsListLoadingView(),
                            )
                            : state.articles == null ||
                                state.articles!.articles.isEmpty
                            ? Center(child: NotFound(notFoundType: NotFoundType.article))
                            : ResponsiveBuilder(
                              builder: (context, deviceType) {
                                return Column(
                                  children: [
                                    for (int i = 0; i < state.articles!.articles.length; i++)
                                      NewsCard(
                                        article: state.articles!.articles[i],
                                      ),
                                    if (state.isLoadingMore)
                                      NewsListLoadingView(),
                                  ],
                                );
                              },
                            ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
