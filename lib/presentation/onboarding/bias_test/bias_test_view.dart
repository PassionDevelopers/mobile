import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/bias_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'political_result_view.dart';

enum QuestionCategory {
  politics('정치'),
  economy('경제'),
  society('사회'),
  culture('문화'),
  international('세계'),
  technology('기술');

  const QuestionCategory(this.displayName);
  final String displayName;
}

class PoliticalQuestion {
  final String text;
  final QuestionCategory category;
  final String leftLabel;
  final String rightLabel;
  final String dimension;
  final String politicalSpectrum;

  PoliticalQuestion({
    required this.text,
    required this.category,
    required this.leftLabel,
    required this.rightLabel,
    required this.dimension,
    required this.politicalSpectrum,
  });
}

class PoliticalTestPage extends StatefulWidget {
  const PoliticalTestPage({super.key});

  @override
  State<PoliticalTestPage> createState() => _PoliticalTestPageState();
}

class _PoliticalTestPageState extends State<PoliticalTestPage> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  final Map<int, int> answers = {};

  final List<PoliticalQuestion> questions = [
    // 정치 카테고리
    PoliticalQuestion(
      text: '정치인의 특권과 면책은 최대한 제한되어야 한다.',
      category: QuestionCategory.politics,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'political',
      politicalSpectrum: 'center',
    ),
    PoliticalQuestion(
      text: '국정감사나 국정조사는 정치적 목적보다 국정 개선에 초점을 맞춰야 한다.',
      category: QuestionCategory.politics,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'political',
      politicalSpectrum: 'center',
    ),
    PoliticalQuestion(
      text: '정부의 정책 결정 과정은 시민들에게 투명하게 공개되어야 한다.',
      category: QuestionCategory.politics,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'political',
      politicalSpectrum: 'center',
    ),

    // 경제 카테고리
    PoliticalQuestion(
      text: '부유층에 대한 세금 부담을 늘려 소득 불평등을 줄여야 한다.',
      category: QuestionCategory.economy,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'economic',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '기업 규제를 완화해 경제 성장을 촉진해야 한다.',
      category: QuestionCategory.economy,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'economic',
      politicalSpectrum: 'right',
    ),
    PoliticalQuestion(
      text: '기본소득 같은 보편적 복지제도가 필요하다.',
      category: QuestionCategory.economy,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'economic',
      politicalSpectrum: 'left',
    ),

    // 사회 카테고리
    PoliticalQuestion(
      text: '성소수자의 권리를 법적으로 보장해야 한다.',
      category: QuestionCategory.society,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'social',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '여성의 사회 진출을 위한 적극적인 정책이 필요하다.',
      category: QuestionCategory.society,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'social',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '종교의 자유는 다른 사람의 인권을 침해하지 않는 선에서 보장되어야 한다.',
      category: QuestionCategory.society,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'social',
      politicalSpectrum: 'center',
    ),

    // 문화 카테고리
    PoliticalQuestion(
      text: '전통 문화보다는 창의적이고 진보적인 문화를 장려해야 한다.',
      category: QuestionCategory.culture,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'cultural',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '문화 다양성을 위해 외국 문화의 유입을 적극 받아들여야 한다.',
      category: QuestionCategory.culture,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'cultural',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '역사 교육에서 우리나라의 부정적 측면도 균형 있게 다뤄야 한다.',
      category: QuestionCategory.culture,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'cultural',
      politicalSpectrum: 'center',
    ),

    // 세계 카테고리
    PoliticalQuestion(
      text: '국익보다는 국제적 협력과 인류 공동의 이익을 우선해야 한다.',
      category: QuestionCategory.international,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'global',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '기후변화 대응을 위해 경제적 손실을 감수해서라도 적극적인 정책이 필요하다.',
      category: QuestionCategory.international,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'global',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '난민과 이민자를 적극적으로 받아들여야 한다.',
      category: QuestionCategory.international,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'global',
      politicalSpectrum: 'left',
    ),

    // 기술 카테고리
    PoliticalQuestion(
      text: 'AI와 자동화로 인한 실업 문제는 정부가 적극 개입해 해결해야 한다.',
      category: QuestionCategory.technology,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'tech',
      politicalSpectrum: 'left',
    ),
    PoliticalQuestion(
      text: '개인정보 보호보다는 기술 발전과 편의성이 더 중요하다.',
      category: QuestionCategory.technology,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'tech',
      politicalSpectrum: 'right',
    ),
    PoliticalQuestion(
      text: '인터넷 규제보다는 표현의 자유를 우선해야 한다.',
      category: QuestionCategory.technology,
      leftLabel: '매우 반대',
      rightLabel: '매우 찬성',
      dimension: 'tech',
      politicalSpectrum: 'left',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentQuestionIndex = index;
                  });
                },
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionPage(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentQuestionIndex + 1) / questions.length;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '정치성향 테스트',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    final question = questions[index];
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                question.text,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: AppColors.primary
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildAnswerButtons(index),
          const SizedBox(height: 40),
          _buildNavigationButtons(index),
        ],
      ),
    );
  }

  Widget _buildAnswerButtons(int questionIndex) {
    return Column(
      children: [
        // 라벨 행
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '매우 반대',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '매우 찬성',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 버튼 행
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final answerValue = index + 1;
            final isSelected = answers[questionIndex] == answerValue;
            
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: index == 0 || index == 4 ? 0 : 4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      answers[questionIndex] = answerValue;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? Theme.of(context).primaryColor 
                        : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Center(
                      child: Text(
                        '$answerValue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected 
                            ? Colors.white 
                            : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        // 숫자 설명
        Text(
          '1: 매우 반대  2: 반대  3: 보통  4: 찬성  5: 매우 찬성',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(int index) {
    return Row(
      children: [
        if (index > 0)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('이전'),
            ),
          ),
        if (index > 0) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: answers[index] != null 
              ? () {
                  if (index < questions.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _calculateResult();
                  }
                }
              : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              index < questions.length - 1 ? '다음' : '결과 보기',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void _calculateResult() {
    if (answers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 질문에 답해주세요.'),
        ),
      );
      return;
    }

    // 성향별 카테고리 점수 초기화
    final Map<String, Map<String, double>> spectrumCategoryScores = {
      'left': {
        'politics': 0.0,
        'economy': 0.0,
        'society': 0.0,
        'culture': 0.0,
        'international': 0.0,
        'technology': 0.0,
      },
      'center': {
        'politics': 0.0,
        'economy': 0.0,
        'society': 0.0,
        'culture': 0.0,
        'international': 0.0,
        'technology': 0.0,
      },
      'right': {
        'politics': 0.0,
        'economy': 0.0,
        'society': 0.0,
        'culture': 0.0,
        'international': 0.0,
        'technology': 0.0,
      },
    };

    final Map<String, Map<String, int>> spectrumCategoryCount = {
      'left': {
        'politics': 0,
        'economy': 0,
        'society': 0,
        'culture': 0,
        'international': 0,
        'technology': 0,
      },
      'center': {
        'politics': 0,
        'economy': 0,
        'society': 0,
        'culture': 0,
        'international': 0,
        'technology': 0,
      },
      'right': {
        'politics': 0,
        'economy': 0,
        'society': 0,
        'culture': 0,
        'international': 0,
        'technology': 0,
      },
    };

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final answer = answers[i]!;
      final spectrum = question.politicalSpectrum;
      final categoryKey = question.category.name;
      
      spectrumCategoryScores[spectrum]![categoryKey] = 
          (spectrumCategoryScores[spectrum]![categoryKey] ?? 0.0) + answer;
      spectrumCategoryCount[spectrum]![categoryKey] = 
          (spectrumCategoryCount[spectrum]![categoryKey] ?? 0) + 1;
    }

    // 성향별 카테고리별 평균 점수 계산하고 WholeBiasScore 생성
    final Map<String, BiasScore> categoryBiasScores = {};
    
    for (final categoryKey in ['politics', 'economy', 'society', 'culture', 'international', 'technology']) {
      double leftScore = 0.0;
      double centerScore = 0.0;
      double rightScore = 0.0;
      
      for (final spectrum in ['left', 'center', 'right']) {
        final count = spectrumCategoryCount[spectrum]![categoryKey]!;
        if (count > 0) {
          final avgScore = spectrumCategoryScores[spectrum]![categoryKey]! / count;
          // 1-5점 범위를 50-70점 범위로 변환
          final normalizedScore = 50 + ((avgScore - 1) / 4) * 20;
          
          switch (spectrum) {
            case 'left':
              leftScore = normalizedScore;
              break;
            case 'center':
              centerScore = normalizedScore;
              break;
            case 'right':
              rightScore = normalizedScore;
              break;
          }
        }
      }
      
      categoryBiasScores[categoryKey] = BiasScore(
        left: leftScore,
        center: centerScore,
        right: rightScore,
      );
    }

    final wholeBiasScore = WholeBiasScore(
      politics: categoryBiasScores['politics']!,
      economy: categoryBiasScores['economy']!,
      society: categoryBiasScores['society']!,
      culture: categoryBiasScores['culture']!,
      international: categoryBiasScores['international']!,
      technology: categoryBiasScores['technology']!,
      createdAt: DateTime.now(),
      userId: 'political_test_user', // 임시 사용자 ID
    );

    context.go(RouteNames.biasTestResult, extra: wholeBiasScore);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}