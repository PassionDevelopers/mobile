import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  //version update later
  static const _keyIgnoredVersion = 'IgnoredVersion';
  static Future setIgnoredVersion(String version) async => await _preferences?.setString(_keyIgnoredVersion, version);
  static String? getIgnoredVersion() => _preferences?.getString(_keyIgnoredVersion);

  static const _keyIdToken = 'IdToken';
  static Future setIdToken(String idToken) async => await _preferences?.setString(_keyIdToken, idToken);
  static String? getIdToken() => _preferences?.getString(_keyIdToken);
}