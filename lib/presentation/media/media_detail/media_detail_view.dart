import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/cards/source_evaluate_card.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/presentation/media/components/media_profile_component.dart';
import 'package:could_be/presentation/media/media_detail/media_detail_loading_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../core/method/bias/bias_enum.dart';
import '../../../core/themes/margins_paddings.dart';
import 'media_detail_view_model.dart';

class MediaDetailView extends StatefulWidget {
  const MediaDetailView({super.key, required this.sourceId});

  final String sourceId;

  @override
  State<MediaDetailView> createState() => _MediaDetailViewState();
}

class _MediaDetailViewState extends State<MediaDetailView> {

  late final viewModel = getIt<MediaDetailViewModel>(param1: widget.sourceId);

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
        isScrollPage: true,
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(children: [
              RegAppBar(title: '언론사 상세보기'),
          ListenableBuilder(
              listenable: viewModel,
              builder: (context, state) {
                final state = viewModel.state;
                if (state.isLoading) {
                  return const MediaDetailLoadingView();
                } else {
                  if (state.sourceDetail == null) {
                    return Center(child: MyText.reg('발견된 언론이 없습니다.'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: MyPaddings.large),
                      // 언론 정보 카드
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MyPaddings.large),
                        child: Ink(
                          padding: EdgeInsets.all(MyPaddings.large),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: myShadow,
                          ),
                          child: Row(
                            children: [
                              MediaProfileDetail(logoUrl: state.sourceDetail!
                                  .logoUrl,),
                              const SizedBox(width: MyPaddings.medium),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.h2(state.sourceDetail!.name,
                                        color: AppColors.primary),
                                    const SizedBox(height: 4),
                                    MyText.small('구독자 ${state.sourceDetail!
                                        .totalIssuesCount}명',
                                        color: AppColors.gray2),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  viewModel
                                      .manageSourceSubscriptionBySourceId();
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Ink(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: state.sourceDetail!.isSubscribed
                                        ? AppColors.gray3
                                        : AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: MyText.small(
                                      state.sourceDetail!.isSubscribed
                                          ? '구독중'
                                          : '구독',
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: MyPaddings.large),

                      // 평가 결과 섹션
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MyPaddings.large),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.h3('평가 결과', color: AppColors.primary),
                            const SizedBox(height: MyPaddings.medium),
                            _buildEvaluationItem(
                              '종합 성향 평가 결과',
                              getBiasFromString(state.sourceDetail!.perspective),
                              Icons.assessment,
                              isPrimary: true,
                            ),
                            _buildEvaluationItem(
                              '다시 스탠드 AI 평가',
                              getBiasFromString(state.sourceDetail!.aiEvaluatedPerspective),
                              Icons.psychology,
                            ),
                            if(state.sourceDetail!.expertEvaluatedPerspective != null)
                              _buildEvaluationItem(
                                '전문가 평가',
                                getBiasFromString(state.sourceDetail!
                                    .expertEvaluatedPerspective!),
                                Icons.verified_user,
                              ),
                            if(state.sourceDetail!.publicEvaluatedPerspective !=
                                null)
                              _buildEvaluationItem(
                                  '사용자 평가',
                                  getBiasFromString(state.sourceDetail!
                                      .publicEvaluatedPerspective!.toString()),
                                  Icons.people_outline
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: MyPaddings.medium),

                      // 사용자 평가 섹션
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MyPaddings.large),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.rate_review_outlined,
                                    color: AppColors.primary, size: 24),
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
                                boxShadow: myShadow,
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
                                  SourceEvaluationRow(
                                    userEvaluatedPerspective: state.sourceDetail!.userEvaluatedPerspective,
                                    onBiasSelected: (bias) {
                                      viewModel.manageSourceEvaluation(
                                        perspective: bias,
                                        context: context
                                      );
                                    },
                                  ),
                                  const SizedBox(height: MyPaddings.large),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: MyPaddings.extraLarge),
                      BottomSafePadding()
                    ],
                  );
                }
              })
            ]
          )),
        );
    }
  Widget _buildEvaluationItem(String title, Bias bias, IconData icon, {bool isPrimary = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: MyPaddings.medium),
      padding: EdgeInsets.all(MyPaddings.medium),
      decoration: BoxDecoration(
        color: isPrimary? AppColors.gray1 : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: myShadow,
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
              color: isPrimary? AppColors.gray5 : AppColors.gray1,
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
              getBiasName(bias),
              color: getBiasColor(bias),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}