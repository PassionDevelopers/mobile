class CommentInputState {
  final String commentText;
  final bool isSubmitting;
  final String? errorMessage;

  CommentInputState({
    this.commentText = '',
    this.isSubmitting = false,
    this.errorMessage,
  });

  CommentInputState copyWith({
    String? commentText,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return CommentInputState(
      commentText: commentText ?? this.commentText,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }
}