import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  //version update later
  static const _keyIgnoredVersion = 'IgnoredVersion';
  static Future setIgnoredVersion(String version) async => await _preferences?.setString(_keyIgnoredVersion, version);
  static String? getIgnoredVersion() => _preferences?.getString(_keyIgnoredVersion);

}