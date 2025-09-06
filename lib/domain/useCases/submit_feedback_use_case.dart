import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/domain/repositoryInterfaces/feedback_interface.dart';

class SubmitFeedbackUseCase {
  final FeedbackInterface _feedbackRepository;

  SubmitFeedbackUseCase(this._feedbackRepository);

  Future<void> execute({
    required String category,
    // required String name,
    required String? email,
    required String? title,
    required String content,
  }) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.submitFeedback,
      parameters: {
        'category': category,
        'has_email': (email != null).toString(),
        'has_title': (title != null).toString(),
      },
    );
    await _feedbackRepository.submitFeedback(
      category: category,
      // name: name,
      email: email,
      title: title,
      content: content,
    );
  }
}