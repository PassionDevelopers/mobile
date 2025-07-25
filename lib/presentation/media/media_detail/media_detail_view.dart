import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../../../core/components/cards/news_card.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/components/layouts/responsive_grid.dart';
import 'media_detail_view_model.dart';

class MediaDetailView extends StatefulWidget {
  const MediaDetailView({super.key, required this.sourceId});
  final String sourceId;

  @override
  State<MediaDetailView> createState() => _MediaDetailViewState();
}

class _MediaDetailViewState extends State<MediaDetailView> {
  Bias? _selectedBias;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<MediaDetailViewModel>(param1: widget.sourceId);
    return RegScaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
      listenable: viewModel,
      builder: (context, state) {
        final state = viewModel.state;
        if(state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }else{
          if (state.sourceDetail == null) {
            return Center(child: MyText.reg('발견된 언론이 없습니다.'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray4.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      height: 56,
                      padding: EdgeInsets.symmetric(horizontal: MyPaddings.small),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          MyText.h2('언론 상세', color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: MyPaddings.large),
                // 언론 정보 카드
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: Ink(
                    padding: EdgeInsets.all(MyPaddings.large),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: myShadow,
                    ),
                    child: Row(
                      children: [
                        MediaProfileDetail(logoUrl: state.sourceDetail!.logoUrl,),
                        const SizedBox(width: MyPaddings.medium),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.h2(state.sourceDetail!.name, color: AppColors.primary),
                              const SizedBox(height: 4),
                              MyText.small('구독자 ${state.sourceDetail!.totalIssuesCount}명', color: AppColors.gray2),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Ink(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: state.sourceDetail!.isSubscribed ? AppColors.gray3 : AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MyText.small(state.sourceDetail!.isSubscribed? '구독중' : '구독',
                                color: AppColors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: MyPaddings.large),

                // 평가 결과 섹션
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.h3('평가 결과', color: AppColors.primary),
                      const SizedBox(height: MyPaddings.medium),
                      _buildEvaluationItem(
                        '편향 평가 결과', 
                        getBiasFromString(state.sourceDetail!.perspective),
                        Icons.assessment,
                      ),
                      _buildEvaluationItem(
                        '다시 스탠드 AI 평가', 
                        getBiasFromString(state.sourceDetail!.aiEvaluatedPerspective),
                        Icons.psychology,
                      ),
                      if(state.sourceDetail!.expertEvaluatedPerspective != null)
                        _buildEvaluationItem(
                          '전문가 평가', 
                          getBiasFromString(state.sourceDetail!.expertEvaluatedPerspective!),
                          Icons.verified_user,
                        ),
                      // if(state.sourceDetail!.userEvaluatedPerspective != null)
                        _buildEvaluationItem(
                          '사용자 평가',
                          // getBiasFromString(state.sourceDetail!.userEvaluatedPerspective!),
                          Bias.right,
                          Icons.people_outline
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: MyPaddings.medium),

                // 사용자 평가 섹션
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.rate_review_outlined, color: AppColors.primary, size: 24),
                          const SizedBox(width: MyPaddings.small),
                          MyText.h3('나의 평가', color: AppColors.primary),
                        ],
                      ),
                      const SizedBox(height: MyPaddings.medium),
                      Ink(
                        padding: EdgeInsets.all(MyPaddings.large),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.gray5),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: MyText.reg(
                                '*다시 스탠드는 사용자의 의견을 반영하여 언론의 성향을 측정합니다. \n\n이 언론사의 성향을 어떻게 평가하시나요?',
                                color: AppColors.gray1,
                                fontWeight: FontWeight.w500,
                                maxLines: 4
                              ),
                            ),
                            const SizedBox(height: MyPaddings.large),
                            _buildBiasSelectionRow(),
                            const SizedBox(height: MyPaddings.large),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _selectedBias != null ? () {
                                  // TODO: 평가 제출 로직
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: MyText.reg('투표를 완료했습니다.', color: AppColors.white),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                } : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  disabledBackgroundColor: AppColors.gray4,
                                ),
                                child: MyText.reg(
                                  '투표하기',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: MyPaddings.extraLarge),

                // 최근 기사 섹션
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                //   child: Row(
                //     children: [
                //       Icon(Icons.article_outlined, color: AppColors.primary, size: 24),
                //       const SizedBox(width: MyPaddings.small),
                //       MyText.h2('최근 기사', color: AppColors.primary),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: MyPaddings.medium),
                //
                // state.sourceDetail!.recentArticles.articles.isEmpty
                //     ? Container(
                //         margin: EdgeInsets.all(MyPaddings.large),
                //         padding: EdgeInsets.all(MyPaddings.extraLarge),
                //         decoration: BoxDecoration(
                //           color: AppColors.gray5,
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         child: Center(
                //           child: Column(
                //             children: [
                //               Icon(Icons.article_outlined, color: AppColors.gray3, size: 48),
                //               SizedBox(height: MyPaddings.medium),
                //               MyText.reg('아직 등록된 기사가 없습니다', color: AppColors.gray2),
                //             ],
                //           ),
                //         ),
                //       )
                //     : ResponsiveBuilder(
                //         builder: (context, deviceType) {
                //           if (ResponsiveUtils.isMobile(context)) {
                //             return Padding(
                //               padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                //               child: Column(
                //                 children: [
                //                   for (int i = 0; i < state.sourceDetail!.recentArticles.articles.length; i++)
                //                     Padding(
                //                       padding: EdgeInsets.only(bottom: MyPaddings.medium),
                //                       child: NewsCard(article: state.sourceDetail!.recentArticles.articles[i]),
                //                     ),
                //                 ],
                //               ),
                //             );
                //           }
                //
                //           return ResponsiveGrid(
                //             children: state.sourceDetail!.recentArticles.articles
                //                 .map((article) => NewsCard(article: article))
                //                 .toList(),
                //           );
                //         },
                //       ),
                //
                // SizedBox(height: MyPaddings.extraLarge),
              ],
            ),
          );
        }
      }
      ),
    );
  }

  Widget _buildEvaluationItem(String title, Bias bias, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: MyPaddings.medium),
      padding: EdgeInsets.all(MyPaddings.medium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.gray5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.gray2,
              size: 20,
            ),
          ),
          SizedBox(width: MyPaddings.medium),
          Expanded(
            child: MyText.reg(
              title,
              color: AppColors.gray1,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getBiasColor(bias).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: MyText.small(
              getBiasName(bias) + '76%',
              color: getBiasColor(bias),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiasSelectionRow() {
    final biasOptions = [
      Bias.left,
      Bias.leftCenter,
      Bias.center,
      Bias.rightCenter,
      Bias.right,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: biasOptions.map((bias) => 
        _buildBiasOption(bias)
      ).toList(),
    );
  }

  Widget _buildBiasOption(Bias bias) {
    final isSelected = _selectedBias == bias;
    
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedBias = bias;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1,
            child: Ink(
              decoration: BoxDecoration(
                color: isSelected ? getBiasColor(bias) : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? getBiasColor(bias) : AppColors.gray4,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: getBiasColor(bias).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ] : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MyText.small(
                      getBiasName(bias),
                      color: isSelected ? AppColors.white : AppColors.gray2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.white : getBiasColor(bias),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}