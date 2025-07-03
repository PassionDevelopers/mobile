import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_enum.dart';
import '../../../core/components/cards/news_card.dart';
import '../../../core/themes/margins_paddings.dart';
import 'media_detail_view_model.dart';

class MediaDetailView extends StatelessWidget {
  const MediaDetailView({super.key, required this.sourceId});
  final String sourceId;
// 중도 선택됨 (0: 진보, 1: 중도진보, 2: 중도, 3: 중도보수, 4: 보수)
  final Color primary = const Color(0xff0A0A0B);

  final Color primaryLight = Colors.white;

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<MediaDetailViewModel>(param1: sourceId);
    return MyScaffold(
      backgroundColor: primaryLight,
      appBar: AppBar(
        backgroundColor: primaryLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '매체 상세 정보',
          style: TextStyle(
            color: primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, state) {
          final state = viewModel.state;
          if(state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }else{
            if (state.sourceDetail == null) {
              return Center(child: Text('발견된 매체가 없습니다.'));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: MyPaddings.medium),
                  // 매체 정보
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium),
                    child: Row(
                      children: [
                        MediaProfileDetail(logoUrl: state.sourceDetail!.logoUrl,),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.h1(state.sourceDetail!.name),
                              const SizedBox(height: 4),
                              MyText.reg('구독자 ${state.sourceDetail!.totalIssuesCount}명'),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '구독',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: MyPaddings.medium),

                  // 평가 결과들
                  _buildEvaluationItem('편향 평가 결과', getBiasFromString(state.sourceDetail!.perspective)),
                  _buildEvaluationItem('다시 스탠드 AI 평가', getBiasFromString(state.sourceDetail!.aiEvaluatedPerspective)),
                  if(state.sourceDetail!.expertEvaluatedPerspective != null)
                    _buildEvaluationItem('전문가 평가', getBiasFromString(state.sourceDetail!.expertEvaluatedPerspective!)),

                  const SizedBox(height: MyPaddings.medium),

                  Padding(
                    padding: EdgeInsets.only(left: MyPaddings.largeMedium),
                    child: BigTitle(title: '최근 기사'),
                  ),

                  state.sourceDetail!.recentArticles.articles.isEmpty
                      ? Center(child: Text('발견된 기사가 없습니다.'))
                      : Column(
                    children: [
                      for (int i = 0; i < state.sourceDetail!.recentArticles.articles.length; i++)
                        NewsCard(article: state.sourceDetail!.recentArticles.articles[i]),
                    ],
                  ),

                ],
              ),
            );
          }
        }
      ),
    );
  }

  Widget _buildEvaluationItem(String title, Bias bias) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium, vertical: MyPaddings.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: primary,
            ),
          ),
          Text(
            getBiasName(bias),
            style: TextStyle(
              color: getBiasColor(bias),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}