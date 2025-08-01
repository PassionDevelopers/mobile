import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:amplitude_flutter/events/identify.dart';
import 'package:could_be/core/di/di_setup.dart';

class AmplitudeAnalyticsHelper {
  static final Amplitude _amplitude = getIt<Amplitude>();

  // Navigation Events
  static Future<void> logNavigationEvent({
    required String fromScreen,
    required String toScreen,
    Map<String, dynamic>? parameters,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'navigate_to_screen',
        eventProperties: {
          'from_screen': fromScreen,
          'to_screen': toScreen,
          ...?parameters,
        },
      ),
    );
  }

  // Tab Navigation Events
  static Future<void> logTabNavigation({
    required int tabIndex,
    required String tabName,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'home_tap_navigation_tab',
        eventProperties: {
          'tab_index': tabIndex,
          'tab_name': tabName,
        },
      ),
    );
  }

  // Authentication Events
  static Future<void> logAuthEvent({
    required String method,
    required String success,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'auth_tap_${method}_login',
        eventProperties: {
          'method': method,
          'success': success,
        },
      ),
    );
  }

  // Issue Events
  static Future<void> logIssueEvent({
    required String action,
    required String issueId,
    Map<String, dynamic>? additionalParams,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'issue_${action}_item',
        eventProperties: {
          'issue_id': issueId,
          ...?additionalParams,
        },
      ),
    );
  }

  // Media Events
  static Future<void> logMediaEvent({
    required String action,
    required String mediaId,
    String? mediaName,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'media_${action}_item',
        eventProperties: {
          'media_id': mediaId,
          if (mediaName != null) 'media_name': mediaName,
        },
      ),
    );
  }

  // Topic Events
  static Future<void> logTopicEvent({
    required String action,
    required String topicId,
    String? topicName,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'topic_${action}_item',
        eventProperties: {
          'topic_id': topicId,
          if (topicName != null) 'topic_name': topicName,
        },
      ),
    );
  }

  // Button/Action Events
  static Future<void> logButtonTap({
    required String module,
    required String buttonName,
    Map<String, String>? parameters,
  }) async {
    await _amplitude.track(
      BaseEvent(
        '${module}_tap_${buttonName}_button',
        eventProperties: parameters,
      ),
    );
  }

  // Form Events
  static Future<void> logFormSubmit({
    required String formName,
    required String success,
    Map<String, dynamic>? parameters,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'form_submit_${formName}',
        eventProperties: {
          'success': success,
          ...?parameters,
        },
      ),
    );
  }

  // Swipe Events
  static Future<void> logSwipeEvent({
    required String module,
    required String itemType,
    required int index,
  }) async {
    await _amplitude.track(
      BaseEvent(
        '${module}_swipe_${itemType}',
        eventProperties: {
          'index': index,
        },
      ),
    );
  }

  // Pull to Refresh Events
  static Future<void> logRefreshEvent({
    required String screenName,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'pull_to_refresh',
        eventProperties: {
          'screen': screenName,
        },
      ),
    );
  }

  // Dialog Events
  static Future<void> logDialogEvent({
    required String action,
    required String dialogName,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'dialog_${action}_${dialogName}',
      ),
    );
  }

  // Search Events
  static Future<void> logSearchEvent({
    required String searchTerm,
    String? searchType,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'search',
        eventProperties: {
          'search_term': searchTerm,
          if (searchType != null) 'search_type': searchType,
        },
      ),
    );
  }

  // Generic Event Logger
  static Future<void> logEvent({
    required String name,
    Map<String, String>? parameters,
  }) async {
    await _amplitude.track(
      BaseEvent(
        name,
        eventProperties: parameters,
      ),
    );
  }

  // Screen View Events
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _amplitude.track(
      BaseEvent(
        'screen_view',
        eventProperties: {
          'screen_name': screenName,
          if (screenClass != null) 'screen_class': screenClass,
        },
      ),
    );
  }

  // User Properties
  static Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (value != null) {
      final identify = Identify()..set(name, value);
      await _amplitude.identify(identify);
    }
  }

  // Set User ID
  static Future<void> setUserId(String? userId) async {
    if (userId != null) {
      await _amplitude.setUserId(userId);
    }
  }
}