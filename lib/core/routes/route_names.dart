
abstract class RouteNames{
  static const
  root = '/',
  home = '/home',
  login = '/login',

  //forced update
  unsupportedDevice = '/unsupportedDevice',
  needUpdate = '/needUpdate',
  serverCheck = '/serverCheck',
  haveUpdate = '/haveUpdate',


  blindSpot = '/blindSpot',

  //topics
  topic = '/topic',
  wholeTopics = '$topic/wholeTopics',
  topicDetail = '$topic/detail',

  //media
  media = '/media',
  mediaDetail = '$media/detail',
  wholeMedia = '$media/wholeMedia',

  //article
  webView = '/webView',

  //my page
  myPage = '/myPage',
  watchHistory = '$myPage/watchHistory',
  subscribedIssue = '$myPage/subscribedIssue',
  userBiasStatus = '$myPage/userBiasStatus',
  manageIssueEvalution = '$myPage/manageIssueEvalution',

  issueDetailFeed = '/issueDetailFeed',
  shortsPlayer = '/shortsPlayer/:issueId'
  ;
}

