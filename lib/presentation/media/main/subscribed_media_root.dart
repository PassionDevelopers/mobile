import 'dart:async';
import 'dart:developer';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/presentation/media/main/subscribed_media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/cards/news_card.dart';
import '../../../core/components/title/big_title_icon.dart';
import '../../../core/di/use_case/use_case.dart';
import '../../../core/themes/margins_paddings.dart';
import '../media_profile_component.dart';
import '../subscribed_media_loading_view.dart';

class SubscribedMediaRoot extends StatefulWidget {
  const SubscribedMediaRoot({super.key});

  @override
  State<SubscribedMediaRoot> createState() => _SubscribedMediaRootState();
}

class _SubscribedMediaRootState extends State<SubscribedMediaRoot> {
  late SubscribedMediaViewModel viewModel;
  StreamSubscription? eventSubscription;

  @override
  void initState() {
    super.initState();
    viewModel = SubscribedMediaViewModel(
      fetchArticlesUseCase: fetchArticlesUseCase,
      fetchSourcesUseCase: fetchSourcesUseCase,
    );

    eventSubscription = viewModel.eventStream.listen((event){
      log(event.toString());
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.toString()),),
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

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MyPaddings.largeMedium,
                  top: MyPaddings.medium,
                ),
                child: BigTitleAdd(title: '관심 매체', onTap: () {
                  context.push(RouteNames.wholeMedia);
                }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MyPaddings.largeMedium,
                ),
                child: state.isSourcesLoading
                    ? CircularProgressIndicator()
                    : state.sources == null
                    ? SizedBox(
                      height: 110,
                      child: Center(child: Text('관심 매체가 없습니다.')),
                    )
                    : SizedBox(
                      height: 110,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final source = state.sources!.sources[index];
                            return MediaProfile(
                             source: source,
                              isShowingArticles: source.id == state.selectedSourceId,
                              onShowArticles: () {
                                if(state.selectedSourceId == source.id) {
                                  viewModel.setSelectedSourceId(null);
                                } else {
                                  viewModel.setSelectedSourceId(source.id);
                                }
                              },
                            );
                          },
                          itemCount: state.sources!.sources.length,
                        ),
                      ),
                    ),
              ),
              state.isArticlesLoading
                  ? SubscribedMediaLoadingView()
                  : state.articles == null
                  ? Center(child: Text('발견된 기사가 없습니다.'))
                  : Column(
                    children: [
                      for (int i = 0; i < state.articles!.articles.length; i++)
                        NewsCard(article: state.articles!.articles[i]),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }
}
