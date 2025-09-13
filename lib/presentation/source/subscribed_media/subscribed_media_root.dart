import 'dart:async';

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/app_bar/subscribe_app_bar.dart';
import 'package:could_be/core/components/loading/media_loading_view.dart';
import 'package:could_be/core/components/loading/news_list_loading_view.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/events/tab_reselection_event.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/source/components/source_bias_tag.dart';
import 'package:could_be/presentation/source/components/source_profile_vertical.dart';
import 'package:could_be/presentation/source/subscribed_media/subscribed_media_action.dart';
import 'package:flutter/material.dart';

import '../../../core/components/cards/news_card.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/themes/margins_paddings.dart';
import 'subscribed_media_view_model.dart';

class SubscribedMediaRoot extends StatefulWidget {
  const SubscribedMediaRoot({super.key});

  @override
  State<SubscribedMediaRoot> createState() => _SubscribedMediaRootState();
}

class _SubscribedMediaRootState extends State<SubscribedMediaRoot> {
  late SubscribedMediaViewModel viewModel;
  StreamSubscription? eventSubscription;
  StreamSubscription<int>? _tabReselectionSubscription;
  final ScrollController scrollController = ScrollController();

  _buildSubscribeButton(){
    return InkWell(
      onTap: (){
        viewModel.onAction(
          SubscribedMediaAction.onTapWholeMedia(),
        );
      },
      child: Ink(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: AppColors.gray300,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Icon(
                      Icons.add, color: AppColors.gray400
                    )
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 42,
              height: 34,
              child: MyText.reg(
                '구독하기',
              ),
            ),
          ],
        ),
      ),
    );
  }

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

    // 탭 재선택 이벤트 리스닝
    _tabReselectionSubscription = TabReselectionEvent.stream.listen((tabIndex) {
      // 언론 탭(3)이 재선택되었을 때
      if (tabIndex == 3) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  dispose() {
    eventSubscription?.cancel();
    _tabReselectionSubscription?.cancel();
    viewModel.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.onAction(SubscribedMediaAction.onRefresh());
      },
      color: Colors.black,
      backgroundColor: Colors.white,
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          bool isSourcesEmpty = state.sources != null && state.sources!.sources.isEmpty;
          return Ink(
            color: AppColors.white,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SubscribeAppBar(
                    title: '관심 언론의 기사 보기',
                    count: state.sources == null? 0 : state.sources!.sources.length,
                    onPressed: () {
                      viewModel.onAction(
                        SubscribedMediaAction.onTapWholeMedia(),
                      );
                    },
                    iconData: Icons.article_outlined,
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
                                color: AppColors.gray500,
                              ),

                              SizedBox(height: MyPaddings.large),
                              Text(
                                '아직 관심 언론이 없습니다',
                                style: MyFontStyle.h1.copyWith(
                                  color: AppColors.gray600,
                                ),
                              ),
                              SizedBox(height: MyPaddings.small),
                              Text(
                                '다양한 언론사를 구독해보세요',
                                style: MyFontStyle.reg.copyWith(
                                  color: AppColors.gray500,
                                ),
                              ),

                              SizedBox(height: MyPaddings.extraLarge),
                              InkWell(
                                onTap: () {
                                  viewModel.onAction(
                                    SubscribedMediaAction.onTapWholeMedia(),
                                  );
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
                      : SizedBox(
                    height: 124,
                    child:
                    state.isSourcesLoading
                        ? MediaLoadingView()
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 6
                      ),
                      itemBuilder: (context, index) {
                        if(index == state.sources!.sources.length){
                          return _buildSubscribeButton();
                        }
                        final source = state.sources!.sources[index];
                        return SourceProfileVertical(
                          source: source,
                          isSelected:
                          source.id == state.selectedSourceId,
                          onSelect: () {
                            viewModel.onAction(
                              SubscribedMediaAction.onSelectSource(
                                sourceId: source.id,
                              ),
                            );
                          },
                        );
                      },
                      itemCount: state.sources!.sources.length + 1,
                    ),
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
                                children: [
                                  MyText.h3(
                                    state.sources!.sources.firstWhere(
                                      (s) => s.id == state.selectedSourceId,
                                    ).name,
                                  ),
                                  const SizedBox(width: 10),
                                  SourceBiasTag(bias: state.sources!.sources.firstWhere(
                                        (s) => s.id == state.selectedSourceId,
                                  ).bias),
                                  Spacer(),
                                  if (state.selectedSourceId != null)
                                    InkWell(
                                      onTap: () {
                                        viewModel.onAction(
                                          SubscribedMediaAction.onTapMediaDetail(
                                            sourceId: state.selectedSourceId!,
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          MyText.reg(
                                            '언론사 상세보기',
                                            color: AppColors.gray600,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                            color: AppColors.gray600,
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
                              ? Center(
                                child: NotFound(
                                  notFoundType: NotFoundType.article,
                                ),
                              )
                              : ResponsiveBuilder(
                                builder: (context, deviceType) {
                                  return Column(
                                    children: [
                                      for (
                                        int i = 0;
                                        i < state.articles!.articles.length;
                                        i++
                                      )
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
            ),
          );
        },
      ),
    );
  }
}
