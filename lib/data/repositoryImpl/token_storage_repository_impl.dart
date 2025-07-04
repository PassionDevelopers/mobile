import 'package:shared_preferences/shared_preferences.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';

class TokenStorageRepositoryImpl extends TokenStorageRepository {
  static const String _tokenKey = 'user_id_token';

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}