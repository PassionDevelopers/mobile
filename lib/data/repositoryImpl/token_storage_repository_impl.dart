import 'dart:developer';

import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';

class TokenStorageRepositoryImpl extends TokenStorageRepository {
  @override
  Future<bool> saveToken(String token) async {
    log('Saving token: $token');
    final bool? result = await UserPreferences.setIdToken(token);
    log('Saving token result: $result');
    return result ?? false;
  }

  @override
  Future<String?> getToken() async {
    return UserPreferences.getIdToken();
  }
}