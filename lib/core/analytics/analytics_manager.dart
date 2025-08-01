import 'package:amplitude_flutter/events/identify.dart';
import 'package:could_be/domain/entities/issue_tag.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'analytics_event_types.dart';

class AnalyticsManager {
  static final FirebaseAnalytics _firebaseAnalytics = getIt<FirebaseAnalytics>();
  static final Amplitude _amplitude = getIt<Amplitude>();
  
  // Navigation Events
  static Future<void> logNavigationEvent(NavigationEvent event, {
    required String? fromScreen,
    required String toScreen,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'navigation_${event.name}';
    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (fromScreen != null) AnalyticsParams.previousScreen: fromScreen,
          AnalyticsParams.screenName: toScreen,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (fromScreen != null) AnalyticsParams.previousScreen: fromScreen,
            AnalyticsParams.screenName: toScreen,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Authentication Events
  static Future<void> logAuthEvent(AuthenticationEvent event, {
    String? method,
    bool? success,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'auth_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (method != null) 'method': method,
          if (success != null) AnalyticsParams.actionResult: success ? 'success' : 'failure',
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (method != null) 'method': method,
            if (success != null) AnalyticsParams.actionResult: success ? 'success' : 'failure',
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Issue Events
  static Future<void> logIssueEvent(IssueEvent event, {
    String? issueId,
    String? issueTitle,
    String? issueCategory,
    List<IssueTag>? issueTags,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'issue_${event.name}';
    String? issueTagsList = issueTags?.map((tag) => tag.name).join(', ');
    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (issueId != null) AnalyticsParams.issueId: issueId,
          if (issueTitle != null) AnalyticsParams.issueTitle: issueTitle,
          if (issueCategory != null) AnalyticsParams.issueCategory: issueCategory,
          if (issueTagsList != null) AnalyticsParams.issueTags: issueTagsList,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (issueId != null) AnalyticsParams.issueId: issueId,
            if (issueTitle != null) AnalyticsParams.issueTitle: issueTitle,
            if (issueCategory != null) AnalyticsParams.issueCategory: issueCategory,
            if (issueTagsList != null) AnalyticsParams.issueTags: issueTagsList,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Media Events
  static Future<void> logMediaEvent(MediaEvent event, {
    String? mediaId,
    String? mediaName,
    String? mediaBias,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'media_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (mediaId != null) AnalyticsParams.mediaId: mediaId,
          if (mediaName != null) AnalyticsParams.mediaName: mediaName,
          if (mediaBias != null) AnalyticsParams.mediaBias: mediaBias,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (mediaId != null) AnalyticsParams.mediaId: mediaId,
            if (mediaName != null) AnalyticsParams.mediaName: mediaName,
            if (mediaBias != null) AnalyticsParams.mediaBias: mediaBias,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Topic Events
  static Future<void> logTopicEvent(TopicEvent event, {
    String? topicId,
    String? topicName,
    String? topicCategory,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'topic_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (topicId != null) AnalyticsParams.topicId: topicId,
          if (topicName != null) AnalyticsParams.topicName: topicName,
          if (topicCategory != null) AnalyticsParams.topicCategory: topicCategory,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (topicId != null) AnalyticsParams.topicId: topicId,
            if (topicName != null) AnalyticsParams.topicName: topicName,
            if (topicCategory != null) AnalyticsParams.topicCategory: topicCategory,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // User Events
  static Future<void> logUserEvent(UserEvent event, {
    String? action,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'user_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (action != null) AnalyticsParams.action: action,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (action != null) AnalyticsParams.action: action,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Social Events
  static Future<void> logSocialEvent(SocialEvent event, {
    String? contentId,
    String? contentType,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'social_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (contentId != null) AnalyticsParams.contentId: contentId,
          if (contentType != null) AnalyticsParams.contentType: contentType,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (contentId != null) AnalyticsParams.contentId: contentId,
            if (contentType != null) AnalyticsParams.contentType: contentType,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Search Events
  static Future<void> logSearchEvent(SearchEvent event, {
    String? searchQuery,
    int? resultCount,
    String? searchFilter,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'search_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (searchQuery != null) AnalyticsParams.searchQuery: searchQuery,
          if (resultCount != null) AnalyticsParams.searchResultCount: resultCount,
          if (searchFilter != null) AnalyticsParams.searchFilter: searchFilter,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (searchQuery != null) AnalyticsParams.searchQuery: searchQuery,
            if (resultCount != null) AnalyticsParams.searchResultCount: resultCount,
            if (searchFilter != null) AnalyticsParams.searchFilter: searchFilter,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Content Events
  static Future<void> logContentEvent(ContentEvent event, {
    String? contentId,
    String? contentType,
    String? contentTitle,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'content_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (contentId != null) AnalyticsParams.contentId: contentId,
          if (contentType != null) AnalyticsParams.contentType: contentType,
          if (contentTitle != null) AnalyticsParams.contentTitle: contentTitle,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (contentId != null) AnalyticsParams.contentId: contentId,
            if (contentType != null) AnalyticsParams.contentType: contentType,
            if (contentTitle != null) AnalyticsParams.contentTitle: contentTitle,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // UI Events
  static Future<void> logUIEvent(UIEvent event, {
    String? elementType,
    String? elementName,
    int? elementPosition,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'ui_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (elementType != null) AnalyticsParams.elementType: elementType,
          if (elementName != null) AnalyticsParams.elementName: elementName,
          if (elementPosition != null) AnalyticsParams.elementPosition: elementPosition,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (elementType != null) AnalyticsParams.elementType: elementType,
            if (elementName != null) AnalyticsParams.elementName: elementName,
            if (elementPosition != null) AnalyticsParams.elementPosition: elementPosition,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // System Events
  static Future<void> logSystemEvent(SystemEvent event, {
    Map<String, String>? additionalParams,
  }) async {
    final eventName = 'system_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: additionalParams,
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: additionalParams,
        ),
      ),
    ]);
  }
  
  // Error Events
  static Future<void> logErrorEvent(ErrorEvent event, {
    String? errorCode,
    String? errorMessage,
    String? errorType,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'error_${event.name}';

    
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: eventName,
        parameters: {
          if (errorCode != null) AnalyticsParams.errorCode: errorCode,
          if (errorMessage != null) AnalyticsParams.errorMessage: errorMessage,
          if (errorType != null) AnalyticsParams.errorType: errorType,
          ...?additionalParams,
        },
      ),
      _amplitude.track(
        BaseEvent(
          eventName,
          eventProperties: {
            if (errorCode != null) AnalyticsParams.errorCode: errorCode,
            if (errorMessage != null) AnalyticsParams.errorMessage: errorMessage,
            if (errorType != null) AnalyticsParams.errorType: errorType,
            ...?additionalParams,
          },
        ),
      ),
    ]);
  }
  
  // Screen View Events
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await Future.wait([
      _firebaseAnalytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      ),
      _amplitude.track(
        BaseEvent(
          'screen_view',
          eventProperties: {
            'screen_name': screenName,
            if (screenClass != null) 'screen_class': screenClass,
          },
        ),
      ),
    ]);
  }
  
  // User Properties
  static Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _firebaseAnalytics.setUserProperty(name: name, value: value);
    final identify = Identify()..set(name, value);
    await _amplitude.identify(identify);
  }
  
  // Set User ID
  static Future<void> setUserId(String? userId) async {
    await Future.wait([
      _firebaseAnalytics.setUserId(id: userId),
      _amplitude.setUserId(userId),
    ]);
  }
  
  // Generic Event Logger (for custom events)
  static Future<void> logCustomEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await Future.wait([
      _firebaseAnalytics.logEvent(
        name: name,
        parameters: parameters,
      ),
      _amplitude.track(
        BaseEvent(
          name,
          eventProperties: parameters,
        ),
      ),
    ]);
  }
}