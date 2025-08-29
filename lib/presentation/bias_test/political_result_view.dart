import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fl_chart/fl_chart.dart';

import 'bias_test_view.dart';

class PoliticalResultPage extends StatelessWidget {
  final Map<String, double> categoryScores;
  final Map<int, int> answers;
  final List<PoliticalQuestion> questions;

  const PoliticalResultPage({
    super.key,
    required this.categoryScores,
    required this.answers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final analysis = _generateAnalysis();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('정치성향 분석 결과'),
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
            _buildScoreChart(context),
            const SizedBox(height: 30),
            _buildDetailedAnalysis(context, analysis),
            const SizedBox(height: 30),
            _buildShareButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSummary(BuildContext context) {
    final dominantCategory = _getDominantCategory();
    final politicalTendency = _getPoliticalTendency();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
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
            '당신의 정치성향',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            politicalTendency,
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
              color: Theme.of(context).primaryColor,
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

  Widget _buildScoreChart(BuildContext context) {
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
          const Text(
            '카테고리별 성향 분석',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: RadarChart(
              RadarChartData(
                dataSets: [
                  RadarDataSet(
                    fillColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    borderColor: Theme.of(context).primaryColor,
                    entryRadius: 3,
                    dataEntries: _getRadarEntries(),
                    borderWidth: 2,
                  ),
                ],
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.3),
                  width: 1,
                ),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                getTitle: (index, angle) {
                  final categories = ['민주주의', '경제', '사회', '문화', '세계관', '기술'];
                  return RadarChartTitle(text: categories[index]);
                },
                tickCount: 5,
                ticksTextStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
                tickBorderData: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                gridBorderData: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildScoreLegend(),
        ],
      ),
    );
  }

  Widget _buildScoreLegend() {
    final categoryNames = {
      'democratic': '민주주의',
      'economic': '경제',
      'social': '사회',
      'cultural': '문화',
      'global': '세계관',
      'tech': '기술',
    };

    return Column(
      children: categoryScores.entries.map((entry) {
        final score = entry.value;
        final percentage = (score / 5.0 * 100).round();
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryNames[entry.key] ?? entry.key,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
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

  Widget _buildShareButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _shareResult(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.share, size: 20),
        label: const Text(
          '결과 공유하기',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<RadarEntry> _getRadarEntries() {
    final orderedCategories = ['democratic', 'economic', 'social', 'cultural', 'global', 'tech'];
    return orderedCategories.map((category) {
      return RadarEntry(value: categoryScores[category] ?? 0.0);
    }).toList();
  }

  String _getDominantCategory() {
    String dominantCategory = '';
    double maxScore = 0.0;
    
    categoryScores.forEach((category, score) {
      if (score > maxScore) {
        maxScore = score;
        dominantCategory = category;
      }
    });
    
    return dominantCategory;
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'democratic':
        return '민주주의';
      case 'economic':
        return '경제';
      case 'social':
        return '사회';
      case 'cultural':
        return '문화';
      case 'global':
        return '세계관';
      case 'tech':
        return '기술';
      default:
        return category;
    }
  }

  String _getPoliticalTendency() {
    final avgScore = categoryScores.values.reduce((a, b) => a + b) / categoryScores.length;
    
    if (avgScore >= 4.0) {
      return '진보 성향';
    } else if (avgScore >= 3.5) {
      return '진보 중도 성향';
    } else if (avgScore >= 2.5) {
      return '중도 성향';
    } else if (avgScore >= 2.0) {
      return '보수 중도 성향';
    } else {
      return '보수 성향';
    }
  }

  String _generateAnalysis() {
    final tendency = _getPoliticalTendency();
    final dominantCategory = _getDominantCategory();
    final dominantScore = categoryScores[dominantCategory] ?? 0.0;
    final avgScore = categoryScores.values.reduce((a, b) => a + b) / categoryScores.length;

    String analysis = '';

    // 전체 성향 분석
    if (avgScore >= 4.0) {
      analysis += '당신은 전반적으로 진보적인 가치관을 가지고 계신 것으로 분석됩니다. 사회 변화와 혁신을 추구하며, 평등과 다양성을 중시하는 경향이 강합니다. ';
    } else if (avgScore >= 3.5) {
      analysis += '당신은 진보 성향을 보이지만 현실적인 접근을 중시하는 것으로 보입니다. 변화의 필요성을 인정하면서도 신중한 접근을 선호합니다. ';
    } else if (avgScore >= 2.5) {
      analysis += '당신은 균형 잡힌 중도적 사고를 가지고 계신 것으로 분석됩니다. 이슈에 따라 유연하게 접근하며, 다양한 관점을 고려하는 편입니다. ';
    } else if (avgScore >= 2.0) {
      analysis += '당신은 보수적 성향을 보이면서도 합리적인 변화는 수용하는 것으로 보입니다. 안정성과 전통을 중시하되 필요한 개선에는 열린 마음을 가지고 있습니다. ';
    } else {
      analysis += '당신은 전통과 안정성을 매우 중시하는 보수적 성향을 가지고 계신 것으로 분석됩니다. 급진적 변화보다는 점진적이고 신중한 접근을 선호합니다. ';
    }

    // 가장 높은 점수 카테고리 분석
    switch (dominantCategory) {
      case 'democratic':
        analysis += '특히 민주주의와 정치 투명성에 대한 관심이 높으며, 정치인의 책임과 시민의 참여를 중요하게 생각합니다.';
        break;
      case 'economic':
        analysis += '경제 정책과 사회 복지에 대한 관심이 높으며, 경제적 불평등과 성장 전략에 대해 뚜렷한 견해를 가지고 있습니다.';
        break;
      case 'social':
        analysis += '사회적 약자의 권리와 사회 정의에 대한 관심이 높으며, 포용성과 다양성을 중시하는 경향이 강합니다.';
        break;
      case 'cultural':
        analysis += '문화와 교육, 역사 인식에 대한 관심이 높으며, 문화적 다양성과 창의성을 중요하게 여깁니다.';
        break;
      case 'global':
        analysis += '국제 관계와 글로벌 이슈에 대한 관심이 높으며, 국제 협력과 인류 공동의 문제에 대해 적극적으로 생각합니다.';
        break;
      case 'tech':
        analysis += '기술 발전과 미래 사회에 대한 관심이 높으며, 기술의 사회적 영향과 규제에 대해 고민하는 편입니다.';
        break;
    }

    return analysis;
  }

  void _shareResult() {
    final tendency = _getPoliticalTendency();
    final dominantCategory = _getCategoryDisplayName(_getDominantCategory());
    
    final shareText = '''
🗳️ 나의 정치성향 분석 결과 🗳️

성향: $tendency
가장 관심 높은 영역: $dominantCategory

정치성향 테스트로 나의 가치관을 알아보세요!
#정치성향테스트 #정치성향분석
''';

    Share.share(shareText);
  }
}