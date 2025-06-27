enum IssueType {
  daily,
  blindSpotLeft,
  blindSpotRight,
  forYou,
  hot,
  watchHistroy,
  subscribed,
  subscribedTopicIssuesWhole,
  subscribedTopicIssuesSpecific;

  String get name{
    return toString().split('.').last;
  }
} 