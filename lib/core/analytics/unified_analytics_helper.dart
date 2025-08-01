import 'package:could_be/core/analytics/firebase_analytics_helper.dart';
import 'package:could_be/core/analytics/amplitude_analytics_helper.dart';

class UnifiedAnalyticsHelper {
  // Navigation Events
  static Future<void> logNavigationEvent({
    required String fromScreen,
    required String toScreen,
    Map<String, dynamic>? parameters,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logNavigationEvent(
        fromScreen: fromScreen,
        toScreen: toScreen,
        parameters: parameters,
      ),
      AmplitudeAnalyticsHelper.logNavigationEvent(
        fromScreen: fromScreen,
        toScreen: toScreen,
        parameters: parameters,
      ),
    ]);
  }

  // Tab Navigation Events
  static Future<void> logTabNavigation({
    required int tabIndex,
    required String tabName,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logTabNavigation(
        tabIndex: tabIndex,
        tabName: tabName,
      ),
      AmplitudeAnalyticsHelper.logTabNavigation(
        tabIndex: tabIndex,
        tabName: tabName,
      ),
    ]);
  }

  // Authentication Events
  static Future<void> logAuthEvent({
    required String method,
    success = true,
  }) async {
    final String successString = success ? 'success' : 'fail';
    await Future.wait([
      FirebaseAnalyticsHelper.logAuthEvent(
        method: method,
        success: successString,
      ),
      AmplitudeAnalyticsHelper.logAuthEvent(
        method: method,
        success: successString,
      ),
    ]);
  }

  // Issue Events
  static Future<void> logIssueEvent({
    required String action,
    required String issueId,
    Map<String, dynamic>? additionalParams,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logIssueEvent(
        action: action,
        issueId: issueId,
        additionalParams: additionalParams,
      ),
      AmplitudeAnalyticsHelper.logIssueEvent(
        action: action,
        issueId: issueId,
        additionalParams: additionalParams,
      ),
    ]);
  }

  // Media Events
  static Future<void> logMediaEvent({
    required String action,
    required String mediaId,
    String? mediaName,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logMediaEvent(
        action: action,
        mediaId: mediaId,
        mediaName: mediaName,
      ),
      AmplitudeAnalyticsHelper.logMediaEvent(
        action: action,
        mediaId: mediaId,
        mediaName: mediaName,
      ),
    ]);
  }

  // Topic Events
  static Future<void> logTopicEvent({
    required String action,
    required String topicId,
    String? topicName,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logTopicEvent(
        action: action,
        topicId: topicId,
        topicName: topicName,
      ),
      AmplitudeAnalyticsHelper.logTopicEvent(
        action: action,
        topicId: topicId,
        topicName: topicName,
      ),
    ]);
  }

  // Button/Action Events
  static Future<void> logButtonTap({
    required String module,
    required String buttonName,
    Map<String, String>? parameters,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logButtonTap(
        module: module,
        buttonName: buttonName,
        parameters: parameters,
      ),
      AmplitudeAnalyticsHelper.logButtonTap(
        module: module,
        buttonName: buttonName,
        parameters: parameters,
      ),
    ]);
  }

  // Form Events
  static Future<void> logFormSubmit({
    required String formName,
    bool success = true,
    Map<String, dynamic>? parameters,
  }) async {
    final String successString = success ? 'success' : 'fail';
    await Future.wait([
      FirebaseAnalyticsHelper.logFormSubmit(
        formName: formName,
        success: successString,
        parameters: parameters,
      ),
      AmplitudeAnalyticsHelper.logFormSubmit(
        formName: formName,
        success: successString,
        parameters: parameters,
      ),
    ]);
  }

  // Swipe Events
  static Future<void> logSwipeEvent({
    required String module,
    required String itemType,
    required int index,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logSwipeEvent(
        module: module,
        itemType: itemType,
        index: index,
      ),
      AmplitudeAnalyticsHelper.logSwipeEvent(
        module: module,
        itemType: itemType,
        index: index,
      ),
    ]);
  }

  // Pull to Refresh Events
  static Future<void> logRefreshEvent({
    required String screenName,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logRefreshEvent(
        screenName: screenName,
      ),
      AmplitudeAnalyticsHelper.logRefreshEvent(
        screenName: screenName,
      ),
    ]);
  }

  // Dialog Events
  static Future<void> logDialogEvent({
    required String action,
    required String dialogName,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logDialogEvent(
        action: action,
        dialogName: dialogName,
      ),
      AmplitudeAnalyticsHelper.logDialogEvent(
        action: action,
        dialogName: dialogName,
      ),
    ]);
  }

  // Search Events
  static Future<void> logSearchEvent({
    required String searchTerm,
    String? searchType,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logSearchEvent(
        searchTerm: searchTerm,
        searchType: searchType,
      ),
      AmplitudeAnalyticsHelper.logSearchEvent(
        searchTerm: searchTerm,
        searchType: searchType,
      ),
    ]);
  }

  // Generic Event Logger
  static Future<void> logEvent({
    required String name,
    Map<String, String>? parameters,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logEvent(
        name: name,
        parameters: parameters,
      ),
      AmplitudeAnalyticsHelper.logEvent(
        name: name,
        parameters: parameters,
      ),
    ]);
  }

  // Screen View Events
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await Future.wait([
      FirebaseAnalyticsHelper.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      ),
      AmplitudeAnalyticsHelper.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      ),
    ]);
  }

  // User Properties
  static Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await FirebaseAnalyticsHelper.setUserProperty(
      name: name,
      value: value,
    );
    await AmplitudeAnalyticsHelper.setUserProperty(
      name: name,
      value: value,
    );
  }

  // Set User ID
  static Future<void> setUserId(String? userId) async {
    await Future.wait([
      FirebaseAnalyticsHelper.setUserId(userId),
      AmplitudeAnalyticsHelper.setUserId(userId),
    ]);
  }
}