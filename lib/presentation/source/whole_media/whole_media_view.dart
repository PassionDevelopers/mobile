import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/presentation/source/components/source_profile_horizontal.dart';
import 'package:could_be/presentation/source/whole_media/whole_media_loading_view.dart';
import 'package:could_be/presentation/source/whole_media/whole_media_state.dart';
import 'package:could_be/presentation/source/whole_media/whole_media_view_model.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/margins_paddings.dart';

class WholeMediaView extends StatelessWidget {
  const WholeMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<WholeMediaViewModel>();
    final List<Bias> biases = [
      Bias.left,
      Bias.center,
      Bias.right,
    ];

    Widget buildTabPage(WholeMediaState state, Bias? bias){
      List<Source>? sources = bias == null
          ? state.sources?.sources
          : state.sources?.sources.where((s) =>
      switch(bias){
        Bias.left => s.bias == Bias.left || s.bias == Bias.leftCenter,
        Bias.center => s.bias == Bias.center,
        Bias.right => s.bias == Bias.right || s.bias == Bias.rightCenter,
        _ => true, // 전체 선택 시 모든 언론사 표시
      }).toList();

      return Column(
        children: [
          Material(
            color: AppColors.white,
            child: Ink(
              color: AppColors.white,
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(sources != null)Text(
                          '${sources.length}개 언론사',
                          style: MyFontStyle.small.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(state.isLoading)
            WholeMediaLoadingView()
          else if (state.sources == null || state.sources!.sources.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: AppColors.gray500,
                  ),
                  SizedBox(height: MyPaddings.medium),
                  Text(
                    '언론 정보를 불러올 수 없습니다',
                    style: MyFontStyle.h2.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: sources!.length,
                  itemBuilder:   (context, index) {
                    final source = sources[index];
                    return SourceProfileHorizontal(
                        source: source,
                        isSelected: source.isSubscribed,
                        onSelect: (){
                          viewModel.manageSourceSubscriptionBySourceId(
                            sourceId: source.id,
                            context: context,
                          );
                        }
                    );
                  },
                ),
              ),
            ),
          BottomSafePadding(),

        ],
      );
    }

    return RegScaffold(
      isScrollPage: true,
      backgroundColor: AppColors.white,
      appBarTitle: '언론사 둘러보기',
      body: Ink(
        color: AppColors.white,
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final state = viewModel.state;
            return DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Material(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TabBar(tabs: [
                        Tab(text: '전체'),
                        Tab(text: biases[0].toString()),
                        Tab(text: biases[1].toString()),
                        Tab(text: biases[2].toString()),
                      ],
                        labelColor: AppColors.black,
                        unselectedLabelColor: AppColors.gray400,
                        indicatorColor: AppColors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildTabPage(state, null),
                        buildTabPage(state, biases[0]),
                        buildTabPage(state, biases[1]),
                        buildTabPage(state, biases[2]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
