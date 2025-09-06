import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/useCases/whole_bias_score_use_case.dart';
import 'package:could_be/presentation/my_page/components/my_bias_status_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bias_test_view.dart';

class PoliticalResultPage extends StatefulWidget {
  final WholeBiasScore wholeBiasScore;


  const PoliticalResultPage({
    super.key,
    required this.wholeBiasScore,
  });

  @override
  State<PoliticalResultPage> createState() => _PoliticalResultPageState();
}

class _PoliticalResultPageState extends State<PoliticalResultPage> {
  Bias currentBias = Bias.left;

  @override
  Widget build(BuildContext context) {
    final analysis = _generateAnalysis();
    final WholeBiasScoreUseCase useCase = getIt<WholeBiasScoreUseCase>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('나의 성향 분석 결과'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultSummary(context),
            const SizedBox(height: 30),
            _buildHexagonChart(),
            const SizedBox(height: 30),
            _buildDetailedAnalysis(context, analysis),
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
                useCase.updateWholeBiasScore(widget.wholeBiasScore);
                context.go(RouteNames.home);
            }),
            const SizedBox(height: 20),

          ],
        ),
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
              wholeBiasScore: widget.wholeBiasScore,
              biasNow: currentBias,
              onBiasChanged: (bias) {
                setState(() {
                  currentBias = bias;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSummary(BuildContext context) {
    final dominantBias = _getDominantBias();
    final dominantCategory = _getDominantCategory();

    final biasColor = getBiasColor(dominantBias);

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
            '${getBiasName(dominantBias)} 성향',
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
              '가장 관심이 높은 영역: ${_getCategoryDisplayName(dominantCategory)}',
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

  Bias _getDominantBias() {
    final leftTotal = widget.wholeBiasScore.getLeftTotal();
    final centerTotal = widget.wholeBiasScore.getCenterTotal();
    final rightTotal = widget.wholeBiasScore.getRightTotal();
    
    if (leftTotal >= centerTotal && leftTotal >= rightTotal) {
      return Bias.left;
    } else if (rightTotal >= centerTotal && rightTotal >= leftTotal) {
      return Bias.right;
    } else {
      return Bias.center;
    }
  }

  String _getDominantCategory() {
    double maxTotal = 0.0;
    String dominantCategory = 'politics';
    
    final categories = {
      'politics': widget.wholeBiasScore.politics.left + 
                  widget.wholeBiasScore.politics.center + 
                  widget.wholeBiasScore.politics.right,
      'economy': widget.wholeBiasScore.economy.left + 
                 widget.wholeBiasScore.economy.center + 
                 widget.wholeBiasScore.economy.right,
      'society': widget.wholeBiasScore.society.left + 
                 widget.wholeBiasScore.society.center + 
                 widget.wholeBiasScore.society.right,
      'culture': widget.wholeBiasScore.culture.left + 
                 widget.wholeBiasScore.culture.center + 
                 widget.wholeBiasScore.culture.right,
      'international': widget.wholeBiasScore.international.left + 
                       widget.wholeBiasScore.international.center + 
                       widget.wholeBiasScore.international.right,
      'technology': widget.wholeBiasScore.technology.left + 
                    widget.wholeBiasScore.technology.center + 
                    widget.wholeBiasScore.technology.right,
    };
    
    categories.forEach((category, total) {
      if (total > maxTotal) {
        maxTotal = total;
        dominantCategory = category;
      }
    });
    
    return dominantCategory;
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

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'politics':
        return '정치';
      case 'economy':
        return '경제';
      case 'society':
        return '사회';
      case 'culture':
        return '문화';
      case 'international':
        return '세계';
      case 'technology':
        return '기술';
      default:
        return category;
    }
  }

  String _generateAnalysis() {
    final dominantBias = _getDominantBias();
    final dominantCategory = _getDominantCategory();
    
    String analysis = '';

    // 전반적인 성향 분석
    switch (dominantBias) {
      case Bias.left || Bias.leftCenter:
        analysis += '당신은 전반적으로 진보적이고 개방적인 가치관을 가지고 계신 것으로 분석됩니다. 변화와 혁신을 받아들이며, 사회적 다양성과 포용을 중시하는 경향이 강합니다. ';
        break;
      case Bias.right || Bias.rightCenter:
        analysis += '당신은 전통적이고 보수적인 가치관을 가지고 계신 것으로 분석됩니다. 기존 질서와 안정성을 중시하며, 검증된 방식과 점진적인 변화를 선호하는 경향이 강합니다. ';
        break;
      case Bias.center:
        analysis += '당신은 중도적이고 균형 잡힌 사고를 가지고 계신 것으로 분석됩니다. 이슈별로 신중하게 접근하며, 극단적인 입장보다는 합리적인 해결책을 선호하는 편입니다. ';
        break;
    }

    // 가장 두드러진 영역 분석
    analysis += String.fromCharCodes([10, 10]); // \n\n
    analysis += '특히 ${_getCategoryDisplayName(dominantCategory)} 영역에서 가장 높은 관심을 보이고 있습니다. ';
    
    switch (dominantCategory) {
      case 'politics':
        analysis += '정치 분야에 대한 관심이 높고, 민주적 가치와 정치적 투명성을 중시하는 성향을 보입니다.';
        break;
      case 'economy':
        analysis += '경제 정책에 대한 뚜렷한 견해를 가지고 있으며, 경제적 정의와 분배에 대해 깊이 생각하는 모습을 보입니다.';
        break;
      case 'society':
        analysis += '사회적 이슈에 대한 관심이 높고, 사회적 소수자와 다양성에 대한 포용적 태도를 보입니다.';
        break;
      case 'culture':
        analysis += '문화적 다양성과 발전에 대한 관심이 높으며, 전통과 혁신의 균형에 대해 깊이 생각하는 모습을 보입니다.';
        break;
      case 'international':
        analysis += '국제적 이슈와 글로벌 협력에 대한 관심이 높으며, 세계적 관점에서 문제를 바라보는 시각을 가지고 있습니다.';
        break;
      case 'technology':
        analysis += '기술 발전과 그 사회적 영향에 대한 관심이 높으며, 기술과 인간의 조화에 대해 깊이 생각하는 모습을 보입니다.';
        break;
    }

    return analysis;
  }

}