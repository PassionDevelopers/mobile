class BiasQuizAnswerVo{
  final int questionId;
  final int? value;

  BiasQuizAnswerVo({
    required this.questionId,
    required this.value,
  });

  toJson(){
    return {
      'questionId': questionId,
      'value': value,
    };
  }
}