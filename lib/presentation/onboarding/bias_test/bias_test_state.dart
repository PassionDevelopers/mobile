import 'package:could_be/domain/entities/bias_quiz_answer_vo.dart';
import 'package:could_be/domain/entities/bias_quiz_vo.dart';

class BiasTestState{
  final bool isLoadingQuiz;
  final List<BiasQuizVo>? quizList;
  final List<BiasQuizAnswerVo>? answerList;
  final int currentPageIndex;

  BiasTestState({
    this.isLoadingQuiz = false,
    this.quizList,
    this.currentPageIndex = 0,
    this.answerList,
  });


  BiasTestState copyWith({
    bool? isLoadingQuiz,
    List<BiasQuizVo>? quizList,
    int? currentPageIndex,
    List<BiasQuizAnswerVo>? answerList,
  }){
    return BiasTestState(
      isLoadingQuiz: isLoadingQuiz ?? this.isLoadingQuiz,
      quizList: quizList ?? this.quizList,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      answerList: answerList ?? this.answerList,
    );
  }

}