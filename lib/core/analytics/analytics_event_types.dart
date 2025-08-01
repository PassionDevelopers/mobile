// Analytics Event Types for Dasi-Stand App
// 모든 사용자 인터렉션에 대한 이벤트 타입 정의

enum AnalyticsEventCategory {
  navigation,
  authentication,
  issue,
  media,
  topic,
  user,
  social,
  search,
  system,
  content,
  ui,
  error,
}

enum NavigationEvent {
  // Bottom Navigation
  tapHomeTab,
  tapIssueTab,
  tapBlindSpotTab,
  tapMediaTab,
  tapMyPageTab,
  
  // Screen Navigation
  navigateToIssueDetail,
  navigateToMediaDetail,
  navigateToTopicDetail,
  navigateToWebView,
  navigateToSettings,
  navigateToNotice,
  navigateToFeedback,
  navigateToLogin,
  navigateToHotIssue,
  navigateToShortsPlayer,
  navigateBack,
}

enum AuthenticationEvent {
  // Login
  tapGoogleLogin,
  tapAppleLogin,
  tapKakaoLogin,
  loginSuccess,
  loginFailure,
  
  // Logout
  tapLogout,
  logoutSuccess,
  
  // Session
  sessionStart,
  sessionEnd,
}

enum IssueEvent {
  // List Actions
  viewIssueList,
  refreshIssueList,
  loadMoreIssues,
  filterIssues,
  sortIssues,
  
  // Detail Actions
  viewIssueDetail,
  tapIssueCard,
  swipeIssue,
  shareIssue,
  bookmarkIssue,
  unbookmarkIssue,
  evaluateIssue,
  
  // Tab Actions
  tapSummaryTab,
  tapArticlesTab,
  tapBiasTab,
  tapSourcesTab,
  
  // Hot Issue
  viewHotIssue,
  swipeHotIssue,
  tapHotIssueMore,
}

enum MediaEvent {
  // List Actions
  viewMediaList,
  searchMedia,
  filterMediaByBias,
  sortMedia,
  
  // Detail Actions
  viewMediaDetail,
  tapMediaCard,
  subscribeMedia,
  unsubscribeMedia,
  evaluateMedia,
  shareMedia,
  
  // Article Actions
  tapArticle,
  readArticle,
  shareArticle,
}

enum TopicEvent {
  // List Actions
  viewTopicList,
  searchTopic,
  filterTopics,
  
  // Detail Actions
  viewTopicDetail,
  tapTopicCard,
  subscribeTopic,
  unsubscribeTopic,
  shareTopic,
}

enum UserEvent {
  // Profile
  viewProfile,
  editProfile,
  updateNickname,
  uploadProfileImage,
  
  // Preferences
  updateNotificationSettings,
  updatePrivacySettings,
  updateContentPreferences,
  
  // History
  viewWatchHistory,
  clearWatchHistory,
  viewSubscribedIssues,
  viewSubscribedMedia,
  viewSubscribedTopics,
  
  // Evaluation
  viewEvaluationHistory,
  deleteEvaluation,
  
  // Bias Analysis
  viewBiasAnalysis,
  viewBiasTrend,
  takePoliticalTest,
}

enum SocialEvent {
  // Comments
  viewComments,
  writeComment,
  editComment,
  deleteComment,
  likeComment,
  reportComment,
  
  // Community
  viewMajorOpinion,
  participateInPoll,
  shareOpinion,
}

enum SearchEvent {
  // Search Actions
  tapSearchBar,
  performSearch,
  clearSearch,
  selectSearchResult,
  viewSearchHistory,
  deleteSearchHistory,
  
  // Search Types
  searchIssues,
  searchMedia,
  searchTopics,
  searchArticles,
}

enum ContentEvent {
  // Shorts Player
  viewShorts,
  playShorts,
  pauseShorts,
  swipeNextShorts,
  swipePreviousShorts,
  tapShortsLike,
  tapShortsShare,
  
  // Article Reading
  startReadingArticle,
  finishReadingArticle,
  scrollArticle,
  tapRelatedArticle,
  
  // External Links
  tapExternalLink,
  openInBrowser,
}

enum UIEvent {
  // Pull to Refresh
  pullToRefresh,
  
  // Dialogs
  openDialog,
  closeDialog,
  confirmDialog,
  cancelDialog,
  
  // Buttons
  tapButton,
  longPressButton,
  
  // Forms
  submitForm,
  cancelForm,
  validateForm,
  
  // Tabs
  switchTab,
  
  // Filters
  applyFilter,
  resetFilter,
  
  // Sorting
  changeSortOrder,
  
  // Pagination
  loadNextPage,
  scrollToTop,
}

enum SystemEvent {
  // App Lifecycle
  appOpen,
  appBackground,
  appForeground,
  appTerminate,
  
  // Updates
  checkForUpdate,
  startUpdate,
  completeUpdate,
  skipUpdate,

  // Deep Links
  openDeepLink,
  
  // Notifications
  receiveNotification,
  tapNotification,
  enableNotifications,
  disableNotifications,
  
  // Permissions
  requestPermission,
  grantPermission,
  denyPermission,
  
  // Network
  networkError,
  networkReconnect,
  
  // Cache
  clearCache,
  cacheHit,
  cacheMiss,
}

enum ErrorEvent {
  // API Errors
  apiError,
  authenticationError,
  networkError,
  
  // UI Errors
  renderError,
  navigationError,
  
  // Data Errors
  parseError,
  validationError,
  
  // System Errors
  crashError,
  memoryError,
}

// Event Parameter Keys
class AnalyticsParams {
  // Common
  static const String timestamp = 'timestamp';
  static const String userId = 'user_id';
  static const String sessionId = 'session_id';
  static const String screenName = 'screen_name';
  static const String previousScreen = 'previous_screen';
  
  // Content
  static const String contentId = 'content_id';
  static const String contentType = 'content_type';
  static const String contentTitle = 'content_title';
  static const String contentCategory = 'content_category';
  
  // Issue
  static const String issueId = 'issue_id';
  static const String issueTitle = 'issue_title';
  static const String issueCategory = 'issue_category';
  static const String issueBias = 'issue_bias';
  static const String issueTags = 'issue_tags';
  
  // Media
  static const String mediaId = 'media_id';
  static const String mediaName = 'media_name';
  static const String mediaBias = 'media_bias';
  static const String mediaCategory = 'media_category';
  
  // Topic
  static const String topicId = 'topic_id';
  static const String topicName = 'topic_name';
  static const String topicCategory = 'topic_category';
  
  // Article
  static const String articleId = 'article_id';
  static const String articleTitle = 'article_title';
  static const String articleSource = 'article_source';
  static const String readingTime = 'reading_time';
  
  // User Actions
  static const String action = 'action';
  static const String actionResult = 'action_result';
  static const String actionDuration = 'action_duration';
  
  // UI Elements
  static const String elementType = 'element_type';
  static const String elementName = 'element_name';
  static const String elementPosition = 'element_position';
  
  // Search
  static const String searchQuery = 'search_query';
  static const String searchResultCount = 'search_result_count';
  static const String searchFilter = 'search_filter';
  
  // Error
  static const String errorCode = 'error_code';
  static const String errorMessage = 'error_message';
  static const String errorType = 'error_type';
  
  // System
  static const String deviceType = 'device_type';
  static const String osVersion = 'os_version';
  static const String appVersion = 'app_version';
  static const String networkType = 'network_type';
}