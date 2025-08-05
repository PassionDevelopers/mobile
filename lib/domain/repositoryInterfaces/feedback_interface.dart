abstract class FeedbackInterface {
  Future<void> submitFeedback({
    required String category,
    // required String name,
    required String? email,
    required String? title,
    required String content,
  });
}