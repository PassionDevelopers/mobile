import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/useCases/submit_feedback_use_case.dart';
import 'package:could_be/presentation/customer_services/feedback_state.dart';
import 'package:flutter/foundation.dart';

class FeedbackViewModel extends ChangeNotifier {
  final SubmitFeedbackUseCase _submitFeedbackUseCase;
  
  FeedbackState _state = FeedbackState();
  FeedbackState get state => _state;

  FeedbackViewModel(this._submitFeedbackUseCase);

  Future<void> submitFeedback({
    required String category,
    // required String name,
    required String? email,
    required String? title,
    required String content,
  }) async {
    _state = _state.copyWith(isSubmitting: true, errorMessage: null);
    notifyListeners();

    try {
      await _submitFeedbackUseCase.execute(
        category: category,
        // name: name,
        email: email,
        title: title,
        content: content,
      );

      _state = _state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      notifyListeners();
      rethrow;
    }
  }

  void resetState() {
    _state = FeedbackState();
    notifyListeners();
  }
}