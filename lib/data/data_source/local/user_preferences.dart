import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  //version update later
  static const _keyIgnoredVersion = 'IgnoredVersion';
  static Future<bool?> setIgnoredVersion(String version) async => await _preferences?.setString(_keyIgnoredVersion, version);
  static String? getIgnoredVersion() => _preferences?.getString(_keyIgnoredVersion);

  static const _keyIdToken = 'IdToken';
  static Future<bool?> setIdToken(String idToken) async => await _preferences?.setString(_keyIdToken, idToken);
  static String? getIdToken() => _preferences?.getString(_keyIdToken);

  static const _keyWatchedArticles = 'WatchedArticles';
  static Future<bool?> setWatchedArticles(List<String> watchedArticles) async => await _preferences?.setStringList(_keyWatchedArticles, watchedArticles);
  static List<String>? getWatchedArticles() => _preferences?.getStringList(_keyWatchedArticles);

  static const _keyPostedDasiScore = 'PostedDasiScore';
  static Future<bool?> setPostedDasiScore(List<String> postedDasiScore) async => await _preferences?.setStringList(_keyPostedDasiScore, postedDasiScore);
  static List<String>? getPostedDasiScore() => _preferences?.getStringList(_keyPostedDasiScore);

}