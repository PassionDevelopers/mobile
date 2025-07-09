class FeedbackState {
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  FeedbackState({
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  FeedbackState copyWith({
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return FeedbackState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}