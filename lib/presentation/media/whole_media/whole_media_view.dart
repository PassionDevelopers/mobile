import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/source.dart';
import 'package:could_be/domain/entities/sources.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/presentation/media/whole_media/whole_media_loading_view.dart' show WholeMediaLoadingView;
import 'package:could_be/presentation/media/whole_media/whole_media_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/margins_paddings.dart';

class WholeMediaView extends StatefulWidget {
  const WholeMediaView({super.key});

  @override
  State<WholeMediaView> createState() => _WholeMediaViewState();
}

class _WholeMediaViewState extends State<WholeMediaView> {
  Bias? selectedBias;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<WholeMediaViewModel>();

    return RegScaffold(
      backgroundColor: AppColors.gray5,
      appBarTitle: '언론사 둘러보기',
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          List<Source>? sources = selectedBias == null
              ? state.sources?.sources
              : state.sources?.sources.where((s) =>
          switch(selectedBias){
            Bias.left => s.bias == Bias.left || s.bias == Bias.leftCenter,
            Bias.center => s.bias == Bias.center,
            Bias.right => s.bias == Bias.right || s.bias == Bias.rightCenter,
            _ => true, // 전체 선택 시 모든 언론사 표시
          }
          ).toList();
          return CustomScrollView(
            slivers: [
              // 필터 섹션을 슬리버로 변경
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.only(bottom: MyPaddings.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '성향별 보기',
                              style: MyFontStyle.h3.copyWith(
                                color: AppColors.gray2,
                              ),
                            ),
                            if(sources != null)Text(
                              '${sources.length}개 언론사',
                              style: MyFontStyle.small.copyWith(
                                color: AppColors.gray3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MyPaddings.medium),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                        child: Row(
                            children: [
                              _buildFilterChip(
                                label: '전체',
                                isSelected: selectedBias == null,
                                onSelected: () {
                                  setState(() {
                                    selectedBias = null;
                                  });
                                },
                              ),
                              SizedBox(width: MyPaddings.small),
                              _buildFilterChip(
                                label: getBiasName(Bias.left),
                                isSelected: selectedBias == Bias.left,
                                color: getBiasColor(Bias.left),
                                onSelected: () {
                                  setState(() {
                                    selectedBias = selectedBias == Bias.left ? null : Bias.left;
                                  });
                                },
                              ),
                              SizedBox(width: MyPaddings.small),
                              _buildFilterChip(
                                label: getBiasName(Bias.center),
                                isSelected: selectedBias == Bias.center,
                                color: getBiasColor(Bias.center),
                                onSelected: () {
                                  setState(() {
                                    selectedBias = selectedBias == Bias.center ? null : Bias.center;
                                  });
                                },
                              ),
                              SizedBox(width: MyPaddings.small),
                              _buildFilterChip(
                                label: getBiasName(Bias.right),
                                isSelected: selectedBias == Bias.right,
                                color: getBiasColor(Bias.right),
                                onSelected: () {
                                  setState(() {
                                    selectedBias = selectedBias == Bias.right ? null : Bias.right;
                                  });
                                },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              if(state.isLoading)
                WholeMediaLoadingView()
              else if (state.sources == null || state.sources!.sources.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                          color: AppColors.gray3,
                        ),
                        SizedBox(height: MyPaddings.medium),
                        Text(
                          '언론 정보를 불러올 수 없습니다',
                          style: MyFontStyle.h2.copyWith(
                            color: AppColors.gray2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else

                SliverPadding(
                padding: EdgeInsets.all(MyPaddings.small),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: MyPaddings.small,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final source = sources[index];
                      return MediaProfile(
                        source: source,
                        isFirst: false,
                        isShowingArticles: source.isSubscribed,
                        onShowArticles: (){
                          viewModel.manageSourceSubscriptionBySourceId(source.id);
                        },
                      );
                    },
                    childCount: sources!.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    Color? color,
    required VoidCallback onSelected,
  }) {
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.large,
          vertical: MyPaddings.small,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? (color ?? AppColors.primary)
              : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? (color ?? AppColors.primary)
                : AppColors.gray4,
          ),
        ),
        child: Text(
          label,
          style: MyFontStyle.reg.copyWith(
            color: isSelected 
                ? AppColors.white
                : (color ?? AppColors.primary),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
