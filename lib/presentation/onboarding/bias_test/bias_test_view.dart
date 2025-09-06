import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/bias_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/presentation/onboarding/bias_test/bias_test_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PoliticalTestPage extends StatefulWidget {
  const PoliticalTestPage({super.key});

  @override
  State<PoliticalTestPage> createState() => _PoliticalTestPageState();
}

class _PoliticalTestPageState extends State<PoliticalTestPage> {

  late final BiasTestViewModel viewModel = getIt<BiasTestViewModel>();
  late final _pageController = viewModel.pageController;

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: false,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          return Column(
            children: [
              if(state.quizList != null)_buildProgressBar(),
              Expanded(
                child: state.quizList == null? Center(child: CircularProgressIndicator(),) : PageView.builder(
                  controller: _pageController,
                  onPageChanged: viewModel.onPageChanged,
                  itemCount: state.quizList!.length,
                  itemBuilder: (context, index) {
                    return _buildQuestionPage(index);
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildProgressBar() {
    final quizList = viewModel.state.quizList!;
    final currentQuizIndex = viewModel.state.currentPageIndex;
    final progress = (viewModel.state.currentPageIndex + 1) / quizList.length;
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
                '${currentQuizIndex + 1}/${quizList.length}',
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
    final quizList = viewModel.state.quizList!;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                quizList[index].text,
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
    final answers = viewModel.state.answerList!;
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
            final isSelected = answers[questionIndex].value == answerValue;
            
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: index == 0 || index == 4 ? 0 : 4),
                child: GestureDetector(
                  onTap: () {
                    viewModel.selectAnswer(quizId: answers[questionIndex].questionId, value: answerValue);
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
    final quizList = viewModel.state.quizList!;
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
            onPressed: viewModel.state.answerList![index].value != null ? () {
                  if (index < quizList.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    viewModel.submitAnswers();
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
              index < quizList.length - 1 ? '다음' : '결과 보기',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}