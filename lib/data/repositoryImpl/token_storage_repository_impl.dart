import 'dart:developer';

import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';

class TokenStorageRepositoryImpl extends TokenStorageRepository {
  @override
  Future<bool> saveToken(String token) async {
    final bool? result = await UserPreferences.setIdToken(token);
    return result ?? false;
  }

  @override
  Future<bool> saveGuestUid(String guestUid) async {
    final bool? result = await UserPreferences.setGuestUid(guestUid);
    return result ?? false;
  }

  @override
  Future<String?> getGuestUid() async{
    return UserPreferences.getGuestUid();
  }

  @override
  Future<String?> getToken() async {
    return UserPreferences.getIdToken();
  }
}