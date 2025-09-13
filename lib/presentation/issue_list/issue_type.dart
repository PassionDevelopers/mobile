enum IssueType {

  daily,
  blindSpotLeft,
  blindSpotRight,
  forYou,
  hot,
  blindSpot,
  opposition,
  nonJoeDiff,


  evaluated,
  watchHistroy,
  subscribed,
  subscribedTopicIssuesWhole,
  subscribedTopicIssuesSpecific;

  String get name{
    if(this == IssueType.blindSpot) {
      return 'blined-spot';
    }else if(this == IssueType.blindSpotLeft) {
      return 'blined-spot-left';
    }else if(this == IssueType.blindSpotRight) {
      return 'blined-spot-right';
    }else if(this == IssueType.nonJoeDiff) {
      return 'non-joe-diff';
    }
    return toString().split('.').last;
  }
}