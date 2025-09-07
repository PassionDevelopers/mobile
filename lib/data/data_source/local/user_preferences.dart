import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  //version update later
  static const _keyIgnoredVersion = 'IgnoredVersion';
  static Future<bool?> setIgnoredVersion(String version) async => await _preferences?.setString(_keyIgnoredVersion, version);
  static String? getIgnoredVersion() => _preferences?.getString(_keyIgnoredVersion);

  //seen notice id
  static const _keySeenNoticeId = 'SeenNoticeId';
  static Future<bool?> setSeenNoticeId(String noticeId) async => await _preferences?.setString(_keySeenNoticeId, noticeId);
  static String? getSeenNoticeId() => _preferences?.getString(_keySeenNoticeId);

  static const _keyIdToken = 'IdToken';
  static Future<bool?> setIdToken(String idToken) async => await _preferences?.setString(_keyIdToken, idToken);
  static String? getIdToken() => _preferences?.getString(_keyIdToken);

  static const _keyGuestUid = 'GuestUid';
  static Future<bool?> setGuestUid(String guestUid) async => await _preferences?.setString(_keyGuestUid, guestUid);
  static String? getGuestUid() => _preferences?.getString(_keyGuestUid);

  static const _keyWatchedArticles = 'WatchedArticles';
  static Future<bool?> setWatchedArticles(List<String> watchedArticles) async => await _preferences?.setStringList(_keyWatchedArticles, watchedArticles);
  static List<String>? getWatchedArticles() => _preferences?.getStringList(_keyWatchedArticles);

  static const _keyPostedDasiScore = 'PostedDasiScore';
  static Future<bool?> setPostedDasiScore(List<String> postedDasiScore) async => await _preferences?.setStringList(_keyPostedDasiScore, postedDasiScore);
  static List<String>? getPostedDasiScore() => _preferences?.getStringList(_keyPostedDasiScore);

  // 유저가 알림 승인 요청에 답변했는지 체크
  static const _keyNotificationPermissionRequested = 'NotificationPermissionRequested';
  static Future<bool?> setNotificationPermissionRequested(bool requested) async => await _preferences?.setBool(_keyNotificationPermissionRequested, requested);
  static bool? getNotificationPermissionRequested() => _preferences?.getBool(_keyNotificationPermissionRequested);

  // 유저 프로필 이미지 url
  static const _keyUserProfileImageUrl = 'UserProfileImageUrl';
  static Future<bool?> setUserProfileImageUrl(String imageUrl) async => await _preferences?.setString(_keyUserProfileImageUrl, imageUrl);
  static String? getUserProfileImageUrl() => _preferences?.getString(_keyUserProfileImageUrl);

  // 온보딩을 만든 후에 그 전 사용자들에게 온보딩을 띄우기 위한 플래그
  static const _keyIsFirstLaunchApp = 'IsFirstLaunchApp';
  static Future<bool?> setIsFirstLaunchApp(bool isFirst) async => await _preferences?.setBool(_keyIsFirstLaunchApp, isFirst);
  static bool? getIsFirstLaunchApp() => _preferences?.getBool(_keyIsFirstLaunchApp);

}