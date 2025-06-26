import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/use_case/use_case.dart';
import 'package:could_be/domain/entities/articles.dart';
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
        fetchArticlesUseCase: fetchArticlesUseCase,
        issueId: issueId, // widget.issueId,
        bias: bias,
        article: article
    );

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return MyScaffold(
      showAppBar: false,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.articlesGroupBySource == null || state.articlesGroupBySource!.articlesWithSources.isEmpty) {
            return Center(child: Text('해당 이슈에 대한 기사가 없습니다.'));
          } else {
            return SlidingUpPanel(
              panel: Center(
                child: Text("This is the sliding Widget"),
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray5,
                  borderRadius: radius
                ),
                child: Column(
                  children: [
                    Expanded(child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MediaProfile(source: state.articlesGroupBySource!.sources[index], isShowingArticles: index == state.currentSourceIndex,
                        onShowArticles: (){
                          viewModel.changeCurrentSourceIndex(index);
                        },);
                        return Text(state.articlesGroupBySource!.sources[state.currentSourceIndex].name);
                      }, itemCount: state.articlesGroupBySource!.sources.length,
                      shrinkWrap: true, physics: BouncingScrollPhysics(),
                    ))
                  ],
                )
              ),

              body: WebViewWidget(controller: viewModel.state.controller!),

              borderRadius: radius,
            );
            return  Container(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Text(state.articlesGroupBySource!.sources[state.currentSourceIndex].name);
                }, itemCount: state.articlesGroupBySource!.sources.length,
                shrinkWrap: true, physics: BouncingScrollPhysics(),
              ),
            );
            return SlidingUpPanel(
              renderPanelSheet: false,
              backdropColor: Colors.black, backdropEnabled: true,
              // color: color,
              // borderRadius: radius,
              collapsed: Container(
                // height: playerH,
                // decoration: BoxDecoration(borderRadius: radius,color: color,),
                child: Column(
                  children: [
                    Icon(Icons.drag_handle_rounded, color: Colors.white,),
                  ],
                ),
              ),
              panel: Container(
                // decoration: BoxDecoration(borderRadius: radius,color: color,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.drag_handle_rounded, color: Colors.white,),
                    Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        padding: const EdgeInsets.only(top:8, bottom: 8),
                        width:double.infinity, height: double.infinity,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('store6.playNowShow'))
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
