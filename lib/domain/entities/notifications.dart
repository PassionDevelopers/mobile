class Notifications{
  final bool commentLikeEnabled;
  final bool commentReplyEnabled;
  final bool majorCommentEnabled;
  final bool issueSubscriptionEnabled;
  final bool mediaSubscriptionEnabled;
  final bool topicSubscriptionEnabled;

  Notifications({
    required this.commentLikeEnabled,
    required this.commentReplyEnabled,
    required this.majorCommentEnabled,
    required this.issueSubscriptionEnabled,
    required this.mediaSubscriptionEnabled,
    required this.topicSubscriptionEnabled,
  });

  Notifications copyWith({
    bool? commentLikeEnabled,
    bool? commentReplyEnabled,
    bool? majorCommentEnabled,
    bool? issueSubscriptionEnabled,
    bool? mediaSubscriptionEnabled,
    bool? topicSubscriptionEnabled,
  }) {
    return Notifications(
      commentLikeEnabled: commentLikeEnabled ?? this.commentLikeEnabled,
      commentReplyEnabled: commentReplyEnabled ?? this.commentReplyEnabled,
      majorCommentEnabled: majorCommentEnabled ?? this.majorCommentEnabled,
      issueSubscriptionEnabled: issueSubscriptionEnabled ?? this.issueSubscriptionEnabled,
      mediaSubscriptionEnabled: mediaSubscriptionEnabled ?? this.mediaSubscriptionEnabled,
      topicSubscriptionEnabled: topicSubscriptionEnabled ?? this.topicSubscriptionEnabled,
    );
  }
}