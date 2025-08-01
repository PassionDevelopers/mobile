import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/repositoryInterfaces/feedback_interface.dart';

class SubmitFeedbackUseCase {
  final FeedbackInterface _feedbackRepository;

  SubmitFeedbackUseCase(this._feedbackRepository);

  Future<void> execute({
    required String category,
    required String name,
    required String email,
    required String title,
    required String content,
  }) async {
    await _feedbackRepository.submitFeedback(
      category: category,
      name: name,
      email: email,
      title: title,
      content: content,
    );
  }
}