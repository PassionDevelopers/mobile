import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/useCases/whole_bias_score_use_case.dart';
import 'package:could_be/presentation/my_page/components/my_bias_status_view.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_result/bias_test_result_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BiasTestResultView extends StatefulWidget {


  const BiasTestResultView({
    super.key, required this.answers,
  });
  final List<BiasQuizAnswerVo> answers;

  @override
  State<BiasTestResultView> createState() => _BiasTestResultViewState();
}

class _BiasTestResultViewState extends State<BiasTestResultView> {
  late final BiasTestResultViewModel viewModel = getIt<BiasTestResultViewModel>(
    param1: widget.answers,
  );

  @override
  Widget build(BuildContext context) {

    return RegScaffold(
      isScrollPage: false,
      appBar: AppBar(
        title: MyText.h1('나의 성향 분석 결과'),
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          return state.isLoading || state.quizResultVo == null? Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            MyText.h2('분석 중입니다...'),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],) : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultSummary(context),
                const SizedBox(height: 30),
                _buildHexagonChart(),
                const SizedBox(height: 30),
                _buildDetailedAnalysis(context, viewModel.state.quizResultVo!.summary),
                const SizedBox(height: 30),
                BigButton(
                  backgroundColor: AppColors.primaryLight,
                    textColor: AppColors.primary,
                    text: '다시 테스트 하기',
                    onPressed: (){
                      context.go(RouteNames.biasTest);
                    }),
                const SizedBox(height: 20),
                BigButton(
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.primaryLight,
                  text: '시작하기',
                  onPressed: (){
                    context.go(RouteNames.home);
                }),
                const SizedBox(height: 20),

              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildHexagonChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '성향별 분석',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: BiasHexagon(
              isZoomed: true,
              wholeBiasScore: viewModel.state.quizResultVo!.wholeBiasScore,
              biasNow: viewModel.state.currentBias,
              onBiasChanged: viewModel.setCurrentBias
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSummary(BuildContext context) {

    final biasColor = getBiasColor(viewModel.state.quizResultVo!.bias);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            biasColor.withValues(alpha: 0.1),
            biasColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            '당신의 성향',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${getBiasName(viewModel.state.quizResultVo!.bias)} 성향',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: biasColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '가장 관심이 높은 영역: ${_getCategoryDisplayName(viewModel.state.quizResultVo!.dominantCategory)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(String category) {
    return switch(category) {
      'politics' => '정치',
      'economy' => '경제',
      'society' => '사회',
      'culture' => '문화',
      'international' => '세계',
      'technology' => '기술',
      _ => category,
    };
  }

  Widget _buildDetailedAnalysis(BuildContext context, String analysis) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                '상세 분석',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            analysis,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

}