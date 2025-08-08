/// Analytics event names as constants
/// This class contains all analytics event names used throughout the app
/// to ensure consistency and prevent typos
class AnalyticsEventNames {
  // App Lifecycle Events
  static const String appOpen = 'app_open';
  static const String appTerminate = 'app_terminate';
  static const String appForeground = 'app_foreground';
  static const String appBackground = 'app_is_background';
  
  // Navigation Events
  static const String navigateToScreen = 'navigate_to_screen';
  static const String homeTabNavigation = 'home_tap_navigation_tab';
  static const String screenView = 'screen_view';
  
  // Authentication Events
  static const String authTapGoogleLogin = 'auth_tap_google_login';
  static const String authTapAppleLogin = 'auth_tap_apple_login';
  static const String authTapEmailLogin = 'auth_tap_email_login';
  static const String authTapGuestLogin = 'auth_tap_guest_login';
  static const String authenticationError = 'authentication_error';

  //Share Events
  static const String shareApp = 'share_app';
  static const String shareIssue = 'share_issue';

  // Issue Events
  static const String issueTapItem = 'issue_tap_item';
  static const String issueViewItem = 'issue_view_item';
  static const String issueSwipeItem = 'issue_swipe_item';
  static const String issueShareItem = 'issue_share_item';
  static const String openHotIssues = 'open_hot_issues';

  // Article Events
  static const String fecthWebArticle = 'fetch_web_article';
  
  // Media Events
  static const String mediaTapItem = 'media_tap_item';
  static const String mediaViewItem = 'media_view_item';
  static const String mediaFollowItem = 'media_follow_item';
  static const String mediaUnfollowItem = 'media_unfollow_item';
  
  // Topic Events
  static const String topicTapItem = 'topic_tap_item';
  static const String topicViewItem = 'topic_view_item';
  static const String topicFollowItem = 'topic_follow_item';
  static const String topicUnfollowItem = 'topic_unfollow_item';
  
  // Button/Action Events - Dynamic event names
  static String buttonTap(String module, String buttonName) => 
      '${module}_tap_${buttonName}_button';
  
  // Form Events - Dynamic event names
  static String formSubmit(String formName) => 
      'form_submit_$formName';
  
  // Swipe Events - Dynamic event names
  static String swipe(String module, String itemType) => 
      '${module}_swipe_$itemType';
  
  // Dialog Events - Dynamic event names
  static String dialog(String action, String dialogName) => 
      'dialog_${action}_$dialogName';
  
  // Search Events
  static const String search = 'search';
  static const String tapSearchBar = 'tap_search_bar';
  static const String clearSearch = 'clear_search';
  
  // Refresh Events
  static const String pullToRefresh = 'pull_to_refresh';
  
  // Update Events
  static const String checkForUpdate = 'check_for_update';
  static const String startUpdate = 'start_update';
  
  // Error Events
  static const String networkError = 'network_error';
  
  // Permission Events
  static const String requestPermission = 'request_permission';
  
  // Deep Link Events
  static const String openDeepLink = 'open_deep_link';
  
  // Dynamic event name builders for specific patterns
  static String authLogin(String method) => 
      'auth_tap_${method}_login';
  
  static String issueAction(String action) => 
      'issue_${action}_item';
  
  static String mediaAction(String action) => 
      'media_${action}_item';
  
  static String topicAction(String action) => 
      'topic_${action}_item';
}