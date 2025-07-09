import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:amplitude_flutter/events/base_event.dart';

abstract class AmplitudeEvents{
  // Authentication Events
  static BaseEvent googleLogin = BaseEvent('Google Login');
  static BaseEvent appleLogin = BaseEvent('Apple Login');
  static BaseEvent emailLogin = BaseEvent('Email Login');
  static BaseEvent guestLogin = BaseEvent('Guest Login');
  static BaseEvent signOut = BaseEvent('Sign Out');
  static BaseEvent deleteUserAccount = BaseEvent('Delete User Account');
  
  // User Management Events
  static BaseEvent checkUserRegisterStatus = BaseEvent('Check User Register Status');
  static BaseEvent registerIdToken = BaseEvent('Register ID Token');
  static BaseEvent deleteUserAccountFromStatus = BaseEvent('Delete User Account From Status');
  
  // Issues Events
  static BaseEvent fetchDailyIssues = BaseEvent('Fetch Daily Issues');
  static BaseEvent fetchHotIssues = BaseEvent('Fetch Hot Issues');
  static BaseEvent fetchBlindSpotLeftIssues = BaseEvent('Fetch Blind Spot Left Issues');
  static BaseEvent fetchBlindSpotRightIssues = BaseEvent('Fetch Blind Spot Right Issues');
  static BaseEvent fetchForYouIssues = BaseEvent('Fetch For You Issues');
  static BaseEvent fetchWatchHistoryIssues = BaseEvent('Fetch Watch History Issues');
  static BaseEvent fetchSubscribedIssues = BaseEvent('Fetch Subscribed Issues');
  static BaseEvent fetchSubscribedTopicIssues = BaseEvent('Fetch Subscribed Topic Issues');
  static BaseEvent fetchIssuesByTopicId = BaseEvent('Fetch Issues By Topic ID');
  static BaseEvent fetchIssuesEvaluated = BaseEvent('Fetch Issues Evaluated');
  static BaseEvent fetchIssueDetailById = BaseEvent('Fetch Issue Detail By ID');
  static BaseEvent fetchQueryParamIssues = BaseEvent('Fetch Query Param Issues');
  
  // Issue Subscription Events
  static BaseEvent subscribeIssue = BaseEvent('Subscribe Issue');
  static BaseEvent unsubscribeIssue = BaseEvent('Unsubscribe Issue');
  
  // Issue Evaluation Events
  static BaseEvent evaluateIssue = BaseEvent('Evaluate Issue');
  static BaseEvent updateIssueEvaluation = BaseEvent('Update Issue Evaluation');
  static BaseEvent deleteIssueEvaluation = BaseEvent('Delete Issue Evaluation');
  
  // Topics Events
  static BaseEvent fetchSubscribedTopics = BaseEvent('Fetch Subscribed Topics');
  static BaseEvent fetchSpecificCategoryTopics = BaseEvent('Fetch Specific Category Topics');
  static BaseEvent fetchTopicDetailById = BaseEvent('Fetch Topic Detail By ID');
  
  // Topic Subscription Events
  static BaseEvent subscribeTopicByTopicId = BaseEvent('Subscribe Topic By Topic ID');
  static BaseEvent unsubscribeTopicByTopicId = BaseEvent('Unsubscribe Topic By Topic ID');
  
  // Media Events
  static BaseEvent fetchSubscribedMedia = BaseEvent('Fetch Subscribed Media');
  
  // Media Subscription Events
  static BaseEvent subscribeSourceBySourceId = BaseEvent('Subscribe Source By Source ID');
  static BaseEvent unsubscribeSourceBySourceId = BaseEvent('Unsubscribe Source By Source ID');
  
  // Sources Events
  static BaseEvent fetchSubscribedSources = BaseEvent('Fetch Subscribed Sources');
  static BaseEvent fetchAllSources = BaseEvent('Fetch All Sources');
  static BaseEvent fetchSourceDetailById = BaseEvent('Fetch Source Detail By ID');
  
  // Articles Events
  static BaseEvent fetchArticlesBySourceId = BaseEvent('Fetch Articles By Source ID');
  static BaseEvent fetchArticlesByIssueId = BaseEvent('Fetch Articles By Issue ID');
  static BaseEvent fetchArticlesSubscribed = BaseEvent('Fetch Articles Subscribed');
  
  // User Bias Events
  static BaseEvent fetchUserBias = BaseEvent('Fetch User Bias');
  
  // Issue Query Params Events
  static BaseEvent fetchIssueQueryParams = BaseEvent('Fetch Issue Query Params');
  
  // Feedback Events
  static BaseEvent submitFeedback = BaseEvent('Submit Feedback');
  
  // Error Events
  static BaseEvent errorOccurred = BaseEvent('Error Occurred');
}



// class Analytics {
//   late Amplitude amplitude;
//
//   // Future<void> init() async {
//   //   // Create and initialize the amplitude instance
//   //   amplitude = Amplitude.getInstance();
//   //   amplitude.init('YOUR_API_KEY_HERE');
//   //
//   //   // Wait until the SDK is initialized
//   //   await amplitude.isBuilt;
//   //
//   //   // Enable COPPA privacy guard. This is useful when you choose not to report sensitive user information.
//   //   amplitude.enableCoppaControl();
//   //
//   //   // Turn on automatic session events
//   //   amplitude.trackingSessionEvents(true);
//   //
//   //   // Log an event for app startup
//   //   amplitude.logEvent('App Startup');
//   // }
//
//   void trackEvent(BaseEvent event) {
//     amplitude.track(event);
//   }
//
//   void setUserId(String userId) {
//     amplitude.setUserId(userId);
//   }
//
//   void flush() {
//     amplitude.flush();
//   }
// }
