import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import '../analytics/analytics_event_names.dart';
import '../analytics/unified_analytics_helper.dart';

Future<void> requestFCMPermission(bool isFirst) async {
  final bool isPermissionRequested = UserPreferences.getNotificationPermissionRequested() ?? false;

  if(!isFirst || !isPermissionRequested) {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(!isFirst){
      await openAppSettings();
    }

    UnifiedAnalyticsHelper.logEvent(
        name: AnalyticsEventNames.requestPermission,
        parameters: {
          'permission_type': 'notifications',
          'result': settings.authorizationStatus.name
        }
    );
    UserPreferences.setNotificationPermissionRequested(true);
  }
}

Future<bool> checkFCMPermissionStatus() async {
  final status = await FirebaseMessaging.instance.getNotificationSettings();
  if (status.authorizationStatus == AuthorizationStatus.authorized ||
      status.authorizationStatus == AuthorizationStatus.provisional) {
    return true;
  } else {
    return false;
  }
}